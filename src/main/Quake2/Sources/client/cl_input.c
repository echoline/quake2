/*
 * Copyright (C) 1997-2001 Id Software, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 *
 * =======================================================================
 *
 * This file implements the input handling like mouse events and
 * keyboard strokes.
 *
 * =======================================================================
 */

#include "client/client.h"
#include "backends/input.h"

cvar_t *cl_nodelta;

extern unsigned sys_frame_time;
unsigned frame_msec;
unsigned old_sys_frame_time;

/*
 * KEY BUTTONS
 *
 * Continuous button event tracking is complicated by the fact that two different
 * input sources (say, mouse button 1 and the control key) can both press the
 * same button, but the button should only be released when both of the
 * pressing key have been released.
 *
 * When a key event issues a button command (+forward, +attack, etc), it appends
 * its key number as a parameter to the command so it can be matched up with
 * the release.
 *
 * state bit 0 is the current state of the key
 * state bit 1 is edge triggered on the up to down transition
 * state bit 2 is edge triggered on the down to up transition
 *
 *   +mlook src time
 */

kbutton_t in_mlook, in_klook;
kbutton_t in_left, in_right, in_forward, in_back;
kbutton_t in_lookup, in_lookdown, in_moveleft, in_moveright;
kbutton_t in_strafe, in_speed, in_use, in_attack;
kbutton_t in_up, in_down;

int in_impulse;

void KeyDown(kbutton_t *b)
{
	int k;
	char *c;

	c = Cmd_Argv(1);

	if (c[0])
		k = (int)strtol(c, (char **)NULL, 10);
	else
		k = -1; /* typed manually at the console for continuous down */

	if ((k == b->down[0]) || (k == b->down[1]))
		return; /* repeating key */

	if (!b->down[0])
		b->down[0] = k;
	else if (!b->down[1])
		b->down[1] = k;
	else
	{
		Com_Printf("Three keys down for a button!\n");
		return;
	}

	if (b->state & 1)
		return; /* still down */

	/* save timestamp */
	c = Cmd_Argv(2);
	b->downtime = (int)strtol(c, (char **)NULL, 10);

	if (!b->downtime)
		b->downtime = sys_frame_time - 100;

	b->state |= 1 + 2; /* down + impulse down */
}

void KeyUp(kbutton_t *b)
{
	int k;
	char *c;
	unsigned uptime;

	c = Cmd_Argv(1);

	if (c[0])
	{
		k = (int)strtol(c, (char **)NULL, 10);
	}
	else
	{
		/* typed manually at the console, assume for unsticking, so clear all */
		b->down[0] = b->down[1] = 0;
		b->state = 4; /* impulse up */
		return;
	}

	if (b->down[0] == k)
		b->down[0] = 0;
	else if (b->down[1] == k)
		b->down[1] = 0;
	else
		return; /* key up without coresponding down (menu pass through) */

	if (b->down[0] || b->down[1])
		return; /* some other key is still holding it down */

	if (!(b->state & 1))
		return; /* still up (this should not happen) */

	/* save timestamp */
	c = Cmd_Argv(2);
	uptime = (int)strtol(c, (char **)NULL, 10);
	if (uptime)
		b->msec += uptime - b->downtime;
	else
		b->msec += 10;

	b->state &= ~1; /* now up */
	b->state |= 4; /* impulse up */
}

void IN_KLookDown()
{
	KeyDown(&in_klook);
}

void IN_KLookUp()
{
	KeyUp(&in_klook);
}

static void IN_MLookDown()
{
	KeyDown(&in_mlook);
}

static void IN_MLookUp()
{
	KeyUp(&in_mlook);
	IN_CenterView();
}

void IN_UpDown()
{
	KeyDown(&in_up);
}

void IN_UpUp()
{
	KeyUp(&in_up);
}

void IN_DownDown()
{
	KeyDown(&in_down);
}

void IN_DownUp()
{
	KeyUp(&in_down);
}

void IN_DownToggleDown()
{
	if (CL_KeyState(&in_down) > 0.0f)
		KeyUp(&in_down);
	else
		KeyDown(&in_down);
}

void IN_DownToggleUp()
{
	// Nothing because this is a toggle.
}

void IN_LeftDown()
{
	KeyDown(&in_left);
}

void IN_LeftUp()
{
	KeyUp(&in_left);
}

void IN_RightDown()
{
	KeyDown(&in_right);
}

void IN_RightUp()
{
	KeyUp(&in_right);
}

void IN_ForwardDown()
{
	KeyDown(&in_forward);
}

void IN_ForwardUp()
{
	KeyUp(&in_forward);
}

void IN_BackDown()
{
	KeyDown(&in_back);
}

void IN_BackUp()
{
	KeyUp(&in_back);
}

void IN_LookupDown()
{
	KeyDown(&in_lookup);
}

void IN_LookupUp()
{
	KeyUp(&in_lookup);
}

void IN_LookdownDown()
{
	KeyDown(&in_lookdown);
}

void IN_LookdownUp()
{
	KeyUp(&in_lookdown);
}

void IN_MoveleftDown()
{
	KeyDown(&in_moveleft);
}

void IN_MoveleftUp()
{
	KeyUp(&in_moveleft);
}

void IN_MoverightDown()
{
	KeyDown(&in_moveright);
}

void IN_MoverightUp()
{
	KeyUp(&in_moveright);
}

void IN_SpeedDown()
{
	KeyDown(&in_speed);
}

void IN_SpeedUp()
{
	KeyUp(&in_speed);
}

void IN_StrafeDown()
{
	KeyDown(&in_strafe);
}

void IN_StrafeUp()
{
	KeyUp(&in_strafe);
}

void IN_AttackDown()
{
	KeyDown(&in_attack);
}

void IN_AttackUp()
{
	KeyUp(&in_attack);
}

void IN_UseDown()
{
	KeyDown(&in_use);
}

void IN_UseUp()
{
	KeyUp(&in_use);
}

void IN_Impulse()
{
	in_impulse = (int)strtol(Cmd_Argv(1), (char **)NULL, 10);
}

/*
 * Returns the fraction of the
 * frame that the key was down
 */
float CL_KeyState(kbutton_t *key)
{
	float val;
	int msec;

	key->state &= 1; /* clear impulses */

	msec = key->msec;
	key->msec = 0;

	if (key->state)
	{
		/* still down */
		msec += sys_frame_time - key->downtime;
		key->downtime = sys_frame_time;
	}

	val = (float)msec / frame_msec;
	if (val < 0)
		val = 0;
	if (val > 1)
		val = 1;

	return val;
}

cvar_t *cl_speed_up;
cvar_t *cl_speed_forward;
cvar_t *cl_speed_side;
cvar_t *cl_speed_yaw;
cvar_t *cl_speed_pitch;
cvar_t *cl_run;
cvar_t *cl_anglespeedkey;

/*
 * Moves the local angle positions
 */
void CL_AdjustAngles()
{
	float speed = cls.frametime;
	if (in_speed.state & 1)
		speed *= cl_anglespeedkey->value;

    float yaw = cl.viewangles[YAW];
	if (!(in_strafe.state & 1))
	{
        float yawSpeed = cl_speed_yaw->value;
		yaw -= speed * yawSpeed * CL_KeyState(&in_right);
		yaw += speed * yawSpeed * CL_KeyState(&in_left);
	}
    cl.viewangles[YAW] = yaw;

    float pitch = cl.viewangles[PITCH];
    float pitchSpeed = cl_speed_pitch->value;
	if (in_klook.state & 1)
	{
		pitch -= speed * pitchSpeed * CL_KeyState(&in_forward);
		pitch += speed * pitchSpeed * CL_KeyState(&in_back);
	}
	float up = CL_KeyState(&in_lookup);
	float down = CL_KeyState(&in_lookdown);
	pitch -= speed * pitchSpeed * up;
	pitch += speed * pitchSpeed * down;   
    cl.viewangles[PITCH] = pitch;
}

/*
 * Send the intended movement message to the server
 */
void CL_BaseMove(usercmd_t *cmd)
{
	CL_AdjustAngles();

	memset(cmd, 0, sizeof(*cmd));

	VectorCopy(cl.viewangles, cmd->angles);

	if (in_strafe.state & 1)
	{
		cmd->sidemove += cl_speed_side->value * CL_KeyState(&in_right);
		cmd->sidemove -= cl_speed_side->value * CL_KeyState(&in_left);
	}

	cmd->sidemove += cl_speed_side->value * CL_KeyState(&in_moveright);
	cmd->sidemove -= cl_speed_side->value * CL_KeyState(&in_moveleft);

	cmd->upmove += cl_speed_up->value * CL_KeyState(&in_up);
	cmd->upmove -= cl_speed_up->value * CL_KeyState(&in_down);

	if (!(in_klook.state & 1))
	{
		cmd->forwardmove += cl_speed_forward->value * CL_KeyState(&in_forward);
		cmd->forwardmove -= cl_speed_forward->value * CL_KeyState(&in_back);
	}

	/* adjust for speed key / running */
	if ((in_speed.state & 1) ^ (int)(cl_run->value))
	{
		cmd->forwardmove *= 2;
		cmd->sidemove *= 2;
		cmd->upmove *= 2;
	}
}

void CL_ClampPitch()
{
	float pitchDelta = SHORT2ANGLE(cl.frame.playerstate.pmove.delta_angles[PITCH]);
	if (pitchDelta > 180)
		pitchDelta -= 360;

    float pitch = cl.viewangles[PITCH];
	if (pitch + pitchDelta < -360)
		pitch += 360; /* wrapped */
	if (pitch + pitchDelta > 360)
		pitch -= 360; /* wrapped */
	if (pitch + pitchDelta > 89)
		pitch = 89 - pitchDelta;
	if (pitch + pitchDelta < -89)
		pitch = -89 - pitchDelta;
    cl.viewangles[PITCH] = pitch;
}

void CL_FinishMove(usercmd_t *cmd)
{
	int ms;
	int i;

	/* figure button bits */
	if (in_attack.state & 3)
	{
		cmd->buttons |= BUTTON_ATTACK;
	}

	in_attack.state &= ~2;

	if (in_use.state & 3)
	{
		cmd->buttons |= BUTTON_USE;
	}

	in_use.state &= ~2;

	if (anykeydown && (cls.key_dest == key_game))
	{
		cmd->buttons |= BUTTON_ANY;
	}

	/* send milliseconds of time to apply the move */
	ms = cls.frametime * 1000;

	if (ms > 250)
	{
		ms = 100; /* time was unreasonable */
	}

	cmd->msec = ms;

	CL_ClampPitch();

	for (i = 0; i < 3; i++)
	{
		cmd->angles[i] = ANGLE2SHORT(cl.viewangles[i]);
	}

	cmd->impulse = in_impulse;
	in_impulse = 0;

	/* send the ambient light level at the player's current position */
	cmd->lightlevel = (byte)cl_lightlevel->value;
}

usercmd_t CL_CreateCmd()
{
	usercmd_t cmd;

	frame_msec = sys_frame_time - old_sys_frame_time;
	if (frame_msec < 1)
		frame_msec = 1;
	if (frame_msec > 200)
		frame_msec = 200;

	/* get basic movement from keyboard */
	CL_BaseMove(&cmd);

	/* allow mice or other external controllers to add to the move */
	IN_Move(&cmd);

	CL_FinishMove(&cmd);

	old_sys_frame_time = sys_frame_time;

	return cmd;
}

void IN_CenterView()
{
	cl.viewangles[PITCH] = -SHORT2ANGLE(cl.frame.playerstate.pmove.delta_angles[PITCH]);
}

/*
 * Centers the view
 */
static void IN_ForceCenterView()
{
	cl.viewangles[PITCH] = 0;
}

void CL_InitInput()
{
	Cmd_AddCommand("centerview", IN_CenterView);
	Cmd_AddCommand("force_centerview", IN_ForceCenterView);

	Cmd_AddCommand("+moveup", IN_UpDown);
	Cmd_AddCommand("-moveup", IN_UpUp);
	Cmd_AddCommand("+movedown", IN_DownDown);
	Cmd_AddCommand("-movedown", IN_DownUp);
	Cmd_AddCommand("+toggledown", IN_DownToggleDown);
	Cmd_AddCommand("-toggledown", IN_DownToggleUp);
	Cmd_AddCommand("+left", IN_LeftDown);
	Cmd_AddCommand("-left", IN_LeftUp);
	Cmd_AddCommand("+right", IN_RightDown);
	Cmd_AddCommand("-right", IN_RightUp);
	Cmd_AddCommand("+forward", IN_ForwardDown);
	Cmd_AddCommand("-forward", IN_ForwardUp);
	Cmd_AddCommand("+back", IN_BackDown);
	Cmd_AddCommand("-back", IN_BackUp);
	Cmd_AddCommand("+lookup", IN_LookupDown);
	Cmd_AddCommand("-lookup", IN_LookupUp);
	Cmd_AddCommand("+lookdown", IN_LookdownDown);
	Cmd_AddCommand("-lookdown", IN_LookdownUp);
	Cmd_AddCommand("+strafe", IN_StrafeDown);
	Cmd_AddCommand("-strafe", IN_StrafeUp);
	Cmd_AddCommand("+moveleft", IN_MoveleftDown);
	Cmd_AddCommand("-moveleft", IN_MoveleftUp);
	Cmd_AddCommand("+moveright", IN_MoverightDown);
	Cmd_AddCommand("-moveright", IN_MoverightUp);
	Cmd_AddCommand("+speed", IN_SpeedDown);
	Cmd_AddCommand("-speed", IN_SpeedUp);
	Cmd_AddCommand("+attack", IN_AttackDown);
	Cmd_AddCommand("-attack", IN_AttackUp);
	Cmd_AddCommand("+use", IN_UseDown);
	Cmd_AddCommand("-use", IN_UseUp);
	Cmd_AddCommand("impulse", IN_Impulse);
	Cmd_AddCommand("+klook", IN_KLookDown);
	Cmd_AddCommand("-klook", IN_KLookUp);
	Cmd_AddCommand("+mlook", IN_MLookDown);
	Cmd_AddCommand("-mlook", IN_MLookUp);

	cl_nodelta = Cvar_Get("cl_nodelta", "0", 0);
}

void CL_SendCmd()
{
	sizebuf_t buf;
	byte data[128];
	int i;
	usercmd_t *cmd, *oldcmd;
	usercmd_t nullcmd;
	int checksumIndex;

	/* build a command even if not connected */

	/* save this command off for prediction */
	i = cls.netchan.outgoing_sequence & (CMD_BACKUP - 1);
	cmd = &cl.cmds[i];
	cl.cmd_time[i] = cls.realtime; /* for netgraph ping calculation */

	*cmd = CL_CreateCmd();

	cl.cmd = *cmd;

	if ((cls.state == ca_disconnected) || (cls.state == ca_connecting))
	{
		return;
	}

	if (cls.state == ca_connected)
	{
		if (cls.netchan.message.cursize ||
		    (curtime - cls.netchan.last_sent > 100))
		{
			byte zero_data = 0;
			Netchan_Transmit(&cls.netchan, 0, &zero_data);
		}

		return;
	}

	/* send a userinfo update if needed */
	if (userinfo_modified)
	{
		CL_FixUpGender();
		userinfo_modified = false;
		MSG_WriteByte(&cls.netchan.message, clc_userinfo);
		MSG_WriteString(&cls.netchan.message, Cvar_Userinfo());
	}

	SZ_Init(&buf, data, sizeof(data));

	if (cmd->buttons && (cl.cinematictime > 0) && !cl.attractloop &&
	    (cls.realtime - cl.cinematictime > 1000))
	{
		/* skip the rest of the cinematic */
		SCR_FinishCinematic();
	}

	/* begin a client move command */
	MSG_WriteByte(&buf, clc_move);

	/* save the position for a checksum byte */
	checksumIndex = buf.cursize;
	MSG_WriteByte(&buf, 0);

	/* let the server know what the last frame we
	   got was, so the next message can be delta
	   compressed */
	if (cl_nodelta->value || !cl.frame.valid || cls.demowaiting)
	{
		MSG_WriteLong(&buf, -1); /* no compression */
	}
	else
	{
		MSG_WriteLong(&buf, cl.frame.serverframe);
	}

	/* send this and the previous cmds in the message, so
	   if the last packet was dropped, it can be recovered */
	i = (cls.netchan.outgoing_sequence - 2) & (CMD_BACKUP - 1);
	cmd = &cl.cmds[i];
	memset(&nullcmd, 0, sizeof(nullcmd));
	MSG_WriteDeltaUsercmd(&buf, &nullcmd, cmd);
	oldcmd = cmd;

	i = (cls.netchan.outgoing_sequence - 1) & (CMD_BACKUP - 1);
	cmd = &cl.cmds[i];
	MSG_WriteDeltaUsercmd(&buf, oldcmd, cmd);
	oldcmd = cmd;

	i = (cls.netchan.outgoing_sequence) & (CMD_BACKUP - 1);
	cmd = &cl.cmds[i];
	MSG_WriteDeltaUsercmd(&buf, oldcmd, cmd);

	/* calculate a checksum over the move commands */
	buf.data[checksumIndex] = COM_BlockSequenceCRCByte(
			buf.data + checksumIndex + 1, buf.cursize - checksumIndex - 1,
			cls.netchan.outgoing_sequence);

	/* deliver the message */
	Netchan_Transmit(&cls.netchan, buf.cursize, buf.data);
}
