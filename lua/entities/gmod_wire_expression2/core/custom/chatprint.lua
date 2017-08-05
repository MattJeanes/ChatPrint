/******************************************************************************\
	Chatprint custom E2 function by Dr. Matt
\******************************************************************************/

E2Lib.RegisterExtension("chatprint", true)
local sbox_E2_ChatPrintAdminOnly = CreateConVar( "sbox_E2_ChatPrintAdminOnly", "0", FCVAR_ARCHIVE )
if SERVER then
	util.AddNetworkString("E2-Custom-ChatPrint")
end

local function canPrint(self, target)
	local ply = self.player
	return sbox_E2_ChatPrintAdminOnly:GetInt()==0 or (sbox_E2_ChatPrintAdminOnly:GetInt()==1 and ply:IsAdmin())
end

local function ChatPrint(self,ply,t,...)
	local args={...}
	if t and type(t)=="table" then args=t end
	if #args>0 then
		if type(args[1])=="string" then
			table.insert(args,1,{255,255,255})
		end
		if !game.SinglePlayer() then
			local str=""
			for k,v in pairs(args) do
				if type(v)=="string" then
					str=str..v
				end
			end
			if IsValid(ply) and ply:IsPlayer() then
				print(self.player:Nick().." to "..ply:Nick()..": "..str)
			else
				print(self.player:Nick()..": "..str)
			end
		end
		net.Start("E2-Custom-ChatPrint")
			net.WriteFloat(#args)
			for k,v in pairs(args) do
				if ( type( v ) == "string" ) then
					net.WriteString( v )
				elseif ( type ( v ) == "table" ) then
					net.WriteFloat( v[1] )
					net.WriteFloat( v[2] )
					net.WriteFloat( v[3] )
				end
			end
		if IsValid(ply) and ply:IsPlayer() then
			net.Send(ply)
		else
			net.Broadcast()
		end
	end
end

--------------------------------------------------------------------------------
e2function void chatPrint(...)
	if not canPrint(self, nil) then return end
	ChatPrint(self,nil,nil,...)
end

e2function void chatPrint(entity ply, ...)
	if not canPrint(self, ply) then return end
	ChatPrint(self,ply,nil,...)
end

e2function void chatPrint(array r)
	if not canPrint(self, nil) then return end
	ChatPrint(self,nil,r)
end

e2function void chatPrint(entity ply, array r)
	if not canPrint(self, ply) then return end
	ChatPrint(self,ply,r)
end
