/******************************************************************************\
	Chatprint custom E2 function by Dr. Matt
\******************************************************************************/

E2Lib.RegisterExtension("chatprint", true)

if SERVER then
	util.AddNetworkString("E2-Custom-ChatPrint")
end

local function ChatPrint(ply,t,...)
	local args={...}
	if t and type(t)=="table" then args=t end
	if #args>0 then
		if type(args[1])=="string" then
			table.insert(args,1,{255,255,255})
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
	ChatPrint(nil,nil,...)
end

e2function void chatPrint(entity ply, ...)
	ChatPrint(ply,nil,...)
end

e2function void chatPrint(array r)
	ChatPrint(nil,r)
end

e2function void chatPrint(entity ply, array r)
	ChatPrint(ply,r)
end