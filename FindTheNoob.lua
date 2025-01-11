-- Danh sách Noobs (thay bằng tên chính xác của các Noob trong game)
local noobLocations = {
    ["skibidi noobie"] = Vector3.new(-1618, -80, 891),
    ["Noob2"] = Vector3.new(20, 10, 25),
    ["Noob3"] = Vector3.new(-5, 8, 30),
    -- Thêm các Noob khác vào danh sách
}

-- Hàm kiểm tra xem người chơi đã thu thập Noob hay chưa
local function hasNoob(noobName)
    local player = game.Players.LocalPlayer
    local inventory = player:FindFirstChild("Inventory") -- Thay thế bằng hệ thống kiểm tra đúng trong game
    if inventory then
        return inventory:FindFirstChild(noobName) ~= nil
    end
    return false
end

-- Hàm tự động bay đến Noob chưa thu thập
local function goToNextNoob()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    for noobName, position in pairs(noobLocations) do
        if not hasNoob(noobName) then
            print("Bay đến: " .. noobName)
            humanoidRootPart.CFrame = CFrame.new(position)
            wait(1) -- Đợi 1 giây để tránh di chuyển quá nhanh
        end
    end
end

-- Kích hoạt hàm khi cần
goToNextNoob()
