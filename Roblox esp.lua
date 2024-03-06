local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Settings for the ESP
local ESP_Settings = {
    TeamCheck = true, -- Whether or not to check for team
    LocalPlayerOnly = false, -- Whether or not to only show the ESP for the local player
    Color = Color3.fromRGB(255, 255, 255), -- Color of the ESP
    TextSize = 10, -- Size of the text
    Transparency = 0.5, -- Transparency of the ESP
}

-- Function to create the ESP for a player
local function createESP(player)
    -- Create a new BillboardGui for the player
    local ESP = Instance.new("BillboardGui")
    ESP.Name = "ESP"
    ESP.AlwaysOnTop = true
    ESP.Size = UDim2.new(1, 0, 1, 0)
    ESP.Adornee = player.Character.Head

    -- Create a new TextLabel for the player's name
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Name"
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = player.Name
    TextLabel.TextColor3 = ESP_Settings.Color
    TextLabel.TextSize = ESP_Settings.TextSize
    TextLabel.Font = Enum.Font.SourceSansBold

    -- Add the TextLabel to the BillboardGui
    TextLabel.Parent = ESP

    -- Connect the BillboardGui to the RunService to update it every frame
    RunService.RenderStepped:Connect(function()
        -- Check if the player is on the same team as the local player
        if ESP_Settings.TeamCheck then
            -- If the players are on the same team, make the ESP invisible
            if player.Team == Players.LocalPlayer.Team then
                ESP.Transparency = 1
            else
                -- If the players are on different teams, make the ESP visible
                ESP.Transparency = ESP_Settings.Transparency
            end
        else
            -- If team check is disabled, make the ESP always visible
            ESP.Transparency = ESP_Settings.Transparency
        end

        -- Check if the player is the local player
        if ESP_Settings.LocalPlayerOnly then
            -- If the player is the local player, make the ESP invisible
            if player == Players.LocalPlayer then
                ESP.Transparency = 1
            else
                -- If the player is not the local player, make the ESP visible
                ESP.Transparency = ESP_Settings.Transparency
            end
        else
            -- If local player only is disabled, make the ESP always visible
            ESP.Transparency = ESP_Settings.Transparency
        end

        -- Update the position of the TextLabel to be at the player's head
        TextLabel.Position = Vector2.new(0, 0)
    end)
end

-- Connect the Players service to the RunService to create the ESP for each player when they join
Players.PlayerAdded:Connect(createESP)