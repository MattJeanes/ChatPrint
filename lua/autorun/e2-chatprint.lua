// chatPrint
// this must be in autorun as it needs to be initialised at game startup rather than when E2 editor opens
if SERVER then
	AddCSLuaFile()
else
	net.Receive("E2-Custom-ChatPrint", function()
		local argc = net.ReadFloat()
		local args = {}
		for i = 1, argc / 2, 1 do
			table.insert( args, Color( net.ReadFloat(), net.ReadFloat(), net.ReadFloat() ) )
			table.insert( args, net.ReadString() )
		end
		chat.AddText( unpack( args ) )
	end)
end