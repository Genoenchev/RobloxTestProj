local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RUN_TESTS = false

if not RunService:IsStudio() then
	return
end

if not RUN_TESTS then
	return
end

local TestEZ = require(ReplicatedStorage.Packages.TestEZ)

print("Running TestEZ tests...")

local results = TestEZ.TestBootstrap:run({
	ReplicatedStorage.Tests,
})

print("Finished TestEZ tests")
print(results)