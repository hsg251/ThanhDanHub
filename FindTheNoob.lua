-- Khởi tạo seed ngẫu nhiên
math.randomseed(tick())

-- Lấy Player và GUI
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local playerGui = player:WaitForChild("PlayerGui")

-- Kiểm tra nếu GUI đã tồn tại
if not playerGui:FindFirstChild("ThanhdanHubGui") then
    -- Tạo ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ThanhdanHubGui"
    screenGui.Parent = playerGui

    -- Tạo TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = screenGui
    textLabel.Size = UDim2.new(0.3, 0, 0.05, 0) -- Kích thước
    textLabel.Position = UDim2.new(0.35, 0, 0, 0) -- Vị trí: giữa màn hình trên cùng
    textLabel.BackgroundTransparency = 1 -- Không có nền
    textLabel.Text = "Thanhdan Hub" -- Dòng chữ hiển thị
    textLabel.Font = Enum.Font.SourceSansBold -- Kiểu chữ
    textLabel.TextSize = 24 -- Kích thước chữ
    textLabel.TextColor3 = Color3.new(1, 1, 1) -- Màu trắng
    textLabel.TextStrokeTransparency = 0 -- Viền chữ
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0) -- Màu viền chữ

    -- Hiệu ứng thay đổi màu liên tục
    spawn(function()
        while true do
            textLabel.TextColor3 = Color3.new(math.random(), math.random(), math.random()) -- Màu ngẫu nhiên
            wait(0.5)
        end
    end)

    -- Hiệu ứng nhấp nháy
    spawn(function()
        while true do
            textLabel.TextTransparency = 0 -- Hiện chữ
            wait(0.5)
            textLabel.TextTransparency = 0.5 -- Ẩn mờ chữ
            wait(0.5)
        end
    end)

    print("Thanhdan Hub đã được thêm vào GUI!")
else
    print("Thanhdan Hub GUI đã tồn tại.")
end

-- Hàm kiểm tra xem Noob đã được thu thập chưa
local function hasNoob(noobName)
    local inventory = player:FindFirstChild("Inventory") -- Thay bằng hệ thống lưu trữ thực tế
    if inventory then
        return inventory:FindFirstChild(noobName) ~= nil
    end
    return false
end

-- Hàm tìm tất cả Noob trong Workspace
local function findAllNoobs()
    local noobs = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and string.find(obj.Name:lower(), "noob") and obj:FindFirstChild("HumanoidRootPart") then
            table.insert(noobs, obj)
        end
    end
    return noobs
end

-- Hàm bay đến Noob
local function flyToNoob(noob)
    if noob:FindFirstChild("HumanoidRootPart") then
        humanoidRootPart.CFrame = noob.HumanoidRootPart.CFrame
        print("Đã bay đến Noob: " .. noob.Name)
    end
end

-- Hàm tự động thu thập Noobs
local function collectNoobs()
    local noobs = findAllNoobs()
    for _, noob in ipairs(noobs) do
        if not hasNoob(noob.Name) then
            flyToNoob(noob) -- Bay đến Noob chưa thu thập
            wait(1) -- Đợi 1 giây trước khi di chuyển tiếp
        else
            print("Đã thu thập Noob: " .. noob.Name)
        end
    end
    print("Thu thập Noobs hoàn tất!")
end

-- Kích hoạt tự động thu thập
collectNoobs()
