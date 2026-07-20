print("Hello world, from server!")

local Players = game:GetService("Players")

local jumpPadsFolder = workspace:WaitForChild("JumpPads")

local DEFAULT_BOOST_POWER = 120
local COOLDOWN_SECONDS = 0.75

local lastBoostByCharacter = {}

local function getCharacterFromTouchedPart(touchedPart: BasePart): Model?
	local character = touchedPart:FindFirstAncestorOfClass("Model")
	if not character then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not rootPart or not rootPart:IsA("BasePart") then
		return nil
	end

	if not Players:GetPlayerFromCharacter(character) then
		return nil
	end

	return character
end

local function boostCharacter(character: Model, jumpPad: BasePart)
	local now = os.clock()
	local lastBoostTime = lastBoostByCharacter[character]

	if lastBoostTime and now - lastBoostTime < COOLDOWN_SECONDS then
		return
	end

	lastBoostByCharacter[character] = now

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not rootPart or not rootPart:IsA("BasePart") then
		return
	end

	local boostPower = jumpPad:GetAttribute("BoostPower")
	if typeof(boostPower) ~= "number" then
		boostPower = DEFAULT_BOOST_POWER
	end

	print("Applying jump pad boost:", boostPower)

	humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

	local impulse = Vector3.new(0, rootPart.AssemblyMass * boostPower, 0)
	rootPart:ApplyImpulse(impulse)
end

local function connectJumpPad(jumpPad: Instance)
	if not jumpPad:IsA("BasePart") then
		return
	end

	jumpPad.Touched:Connect(function(touchedPart)
		local character = getCharacterFromTouchedPart(touchedPart)
		if not character then
			return
		end

		boostCharacter(character, jumpPad)
	end)
end

for _, jumpPad in jumpPadsFolder:GetChildren() do
	connectJumpPad(jumpPad)
end

jumpPadsFolder.ChildAdded:Connect(connectJumpPad)