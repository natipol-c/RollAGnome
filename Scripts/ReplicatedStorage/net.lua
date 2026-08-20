--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     net
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.net
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = game:GetService("RunService"):IsServer() and "server" or "client";

local function assert_run_context(p2) -- Line: 69
    -- upvalues: u1 (copy)
    local v3 = `expected run context {p2} but got {u1}`;
    assert(u1 == p2, v3);
end;

local u4 = nil;
local u5 = {
    client = {
        initialized = false
    },
    server = {
        initialized = false
    }
};

function u5.server.init() -- Line: 87
    -- upvalues: u1 (copy), ReplicatedStorage (copy), u4 (ref), u5 (copy)
    local v6 = `expected run context server but got {u1}`;
    assert(u1 == "server", v6);
    local Folder = Instance.new("Folder");
    Folder.Name = "conch_networking";
    Folder.Parent = ReplicatedStorage;

    local function remote(p7) -- Line: 94
        -- upvalues: Folder (copy)
        local RemoteEvent = Instance.new("RemoteEvent");
        RemoteEvent.Name = p7;
        RemoteEvent.Parent = Folder;

        return RemoteEvent;
    end;

    local v8 = {};
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "invoke_server_command";
    RemoteEvent.Parent = Folder;
    v8.invoke_server_command = RemoteEvent;
    local RemoteEvent2 = Instance.new("RemoteEvent");
    RemoteEvent2.Name = "create_user";
    RemoteEvent2.Parent = Folder;
    v8.create_user = RemoteEvent2;
    local RemoteEvent3 = Instance.new("RemoteEvent");
    RemoteEvent3.Name = "update_user_roles";
    RemoteEvent3.Parent = Folder;
    v8.update_user_roles = RemoteEvent3;
    local RemoteEvent4 = Instance.new("RemoteEvent");
    RemoteEvent4.Name = "update_role_permissions";
    RemoteEvent4.Parent = Folder;
    v8.update_role_permissions = RemoteEvent4;
    local RemoteEvent5 = Instance.new("RemoteEvent");
    RemoteEvent5.Name = "register_command";
    RemoteEvent5.Parent = Folder;
    v8.register_command = RemoteEvent5;
    local RemoteEvent6 = Instance.new("RemoteEvent");
    RemoteEvent6.Name = "log";
    RemoteEvent6.Parent = Folder;
    v8.log = RemoteEvent6;
    local RemoteEvent7 = Instance.new("RemoteEvent");
    RemoteEvent7.Name = "log_command";
    RemoteEvent7.Parent = Folder;
    v8.log_command = RemoteEvent7;
    u4 = v8;
    u5.server.initialized = true;
end;

function u5.client.init() -- Line: 117
    -- upvalues: u1 (copy), ReplicatedStorage (copy), u4 (ref), u5 (copy)
    local v9 = `expected run context client but got {u1}`;
    assert(u1 == "client", v9);
    local conch_networking = ReplicatedStorage:WaitForChild("conch_networking");

    local function _(p10) -- Line: 122
        -- upvalues: conch_networking (copy)
        return conch_networking:WaitForChild(p10);
    end;

    u4 = {
        invoke_server_command = conch_networking:WaitForChild("invoke_server_command"),
        create_user = conch_networking:WaitForChild("create_user"),
        update_user_roles = conch_networking:WaitForChild("update_user_roles"),
        update_role_permissions = conch_networking:WaitForChild("update_role_permissions"),
        register_command = conch_networking:WaitForChild("register_command"),
        log = conch_networking:WaitForChild("log"),
        log_command = conch_networking:WaitForChild("log_command")
    };
    u5.client.initialized = true;
end;

function u5.client.on_user_roles_update(p11) -- Line: 141
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v12 = `expected run context client but got {u1}`;
    assert(u1 == "client", v12);
    u4.update_user_roles.OnClientEvent:Connect(p11);
end;

function u5.client.on_command_registered(p13) -- Line: 152
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v14 = `expected run context client but got {u1}`;
    assert(u1 == "client", v14);
    u4.register_command.OnClientEvent:Connect(p13);
end;

function u5.client.on_role_info_received(p15) -- Line: 161
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v16 = `expected run context client but got {u1}`;
    assert(u1 == "client", v16);
    u4.update_role_permissions.OnClientEvent:Connect(p15);
end;

function u5.client.on_user_info_received(p17) -- Line: 170
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v18 = `expected run context client but got {u1}`;
    assert(u1 == "client", v18);
    u4.create_user.OnClientEvent:Connect(p17);
end;

function u5.client.on_log_received(p19) -- Line: 177
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v20 = `expected run context client but got {u1}`;
    assert(u1 == "client", v20);
    u4.log.OnClientEvent:Connect(p19);
end;

function u5.client.invoke_command(p21, p22, p23) -- Line: 184
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v24 = `expected run context client but got {u1}`;
    assert(u1 == "client", v24);
    u4.invoke_server_command:FireServer({
        invoke_id = p21,
        name = p22,
        args = p23
    });
end;

function u5.client.on_invoke_reply(p25) -- Line: 201
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v26 = `expected run context client but got {u1}`;
    assert(u1 == "client", v26);
    u4.invoke_server_command.OnClientEvent:Connect(p25);
end;

function u5.client.fire_log_command(p27) -- Line: 208
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.client.initialized, "client not initialized");
    local v28 = `expected run context client but got {u1}`;
    assert(u1 == "client", v28);
    u4.log_command:FireServer(p27);
end;

function u5.server.on_log_command(p29) -- Line: 215
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v30 = `expected run context server but got {u1}`;
    assert(u1 == "server", v30);

    return u4.log_command.OnServerEvent:Connect(p29);
end;

function u5.server.fire_log(p31, p32) -- Line: 222
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v33 = `expected run context server but got {u1}`;
    assert(u1 == "server", v33);
    u4.log:FireClient(p31, p32);
end;

function u5.server.fire_register_command(p34, p35) -- Line: 229
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v36 = `expected run context server but got {u1}`;
    assert(u1 == "server", v36);
    u4.register_command:FireClient(p34, p35);
end;

function u5.server.on_command_invoke(p37) -- Line: 239
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v38 = `expected run context server but got {u1}`;
    assert(u1 == "server", v38);
    u4.invoke_server_command.OnServerEvent:Connect(p37);
end;

function u5.server.fire_successful_invoke_reply(p39, p40, p41) -- Line: 249
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v42 = `expected run context server but got {u1}`;
    assert(u1 == "server", v42);
    u4.invoke_server_command:FireClient(p39, {
        status = "ok",
        invoke_id = p40,
        results = p41
    });
end;

function u5.server.fire_failed_invoke_reply(p43, p44) -- Line: 266
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v45 = `expected run context server but got {u1}`;
    assert(u1 == "server", v45);
    u4.invoke_server_command:FireClient(p43, {
        status = "err",
        invoke_id = p44
    });
end;

function u5.server.fire_create_user(p46, p47, p48) -- Line: 278
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v49 = `expected run context server but got {u1}`;
    assert(u1 == "server", v49);
    u4.create_user:FireClient(p46, {
        name = p48,
        id = p47
    });
end;

function u5.server.fire_update_user_roles(p50, p51) -- Line: 290
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v52 = `expected run context server but got {u1}`;
    assert(u1 == "server", v52);
    u4.update_user_roles:FireClient(p50, p51);
end;

function u5.server.fire_update_role_perms(p53, p54) -- Line: 300
    -- upvalues: u5 (copy), u1 (copy), u4 (ref)
    assert(u5.server.initialized, "server not initialized");
    local v55 = `expected run context server but got {u1}`;
    assert(u1 == "server", v55);
    u4.update_role_permissions:FireAllClients({
        name = p53,
        permissions = p54
    });
end;

return u5;