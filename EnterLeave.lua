FuRegisterClass("EnterLeave", CT_Tool, {
    REGS_Name = "EnterLeave",
    REGS_Category = "Fuses",
    REGS_OpIconString = "ELv",
    REGS_OpDescription = "Remap your Enter and Leave animations to a single keyframable slider.",
    REGS_URL = "https://www.buymeacoffee.com/brunoreis",
    REGS_IconID = "Icons.Tools.Icons.TimeStretcher",
    REG_OpNoMask = true,
    REG_NoMotionBlurCtrls = true,
    REG_NoBlendCtrls = true,
    REG_NoObjMatCtrls = true,
    -- REG_Fuse_NoEdit = true,
    -- REG_Fuse_NoReload = true,
    -- REG_OpTileColor = { G = 0.66, R = 0.89, B = 0.11 },
    -- REGS_OpTileColor = "yellow",
})



function Create()
    InAnimate = self:AddInput("Animate", "Animate", {
        LINKID_DataType = "Number",
        INPID_InputControl = "SliderControl",
        INP_MaxScale = 1,
        INP_MinScale = -1,
        INP_Default = 0,
    })

    self:BeginControlNest("Enter", "Enter", true)

    InEnterStart = self:AddInput("Start", "EnterStart", {
        LINKID_DataType = "Number",
        INPID_InputControl = "RangeControl",
        IC_ControlGroup = 1,
        IC_ControlID = 0,
        INP_MaxScale = 100,
        INP_MinScale = 0,
        IC_DisplayedPrecision = 0,
        INP_Default = 0,
        INP_External = false,
        -- INPS_StatusText = "Enter Animation Start Frame"
    })

    InEnterEnd = self:AddInput("End", "EnterEnd", {
        LINKID_DataType = "Number",
        INPID_InputControl = "RangeControl",
        IC_ControlGroup = 1,
        IC_ControlID = 1,
        INP_MaxScale = 100,
        INP_MinScale = 0,
        IC_DisplayedPrecision = 0,
        INP_Default = 50,
        INP_External = false,
        -- INPS_StatusText = "Enter Animation End Frame"
    })

    self:EndControlNest()

    self:BeginControlNest("Leave", "Leave", true)
    InLeaveStart = self:AddInput("Start", "LeaveStart", {
        LINKID_DataType = "Number",
        INPID_InputControl = "RangeControl",
        IC_ControlGroup = 2,
        IC_ControlID = 0,
        INP_MaxScale = 100,
        INP_MinScale = 0,
        IC_DisplayedPrecision = 0,
        INP_Default = 50,
        INP_External = false,
        -- INPS_StatusText = "Leave Animation Leave Frame"
    })

    InLeaveEnd = self:AddInput("End", "LeaveEnd", {
        LINKID_DataType = "Number",
        INPID_InputControl = "RangeControl",
        IC_ControlGroup = 2,
        IC_ControlID = 1,
        INP_MaxScale = 100,
        INP_MinScale = 0,
        IC_DisplayedPrecision = 0,
        INP_Default = 100,
        INP_External = false,
        -- INPS_StatusText = "Leave Animation End Frame"
    })
    self:EndControlNest()

    InImage = self:AddInput("Input", "Input", {
        LINKID_DataType = "Image",
        LINK_Main = 1,
    })
    OutImage = self:AddOutput("Output", "Output", {
        LINKID_DataType = "Image",
        LINK_Main = 1,
    })
end

-- function OnAddToFlow()

-- end


function Process(req)
    -- OutImage:Set(req, InImage:GetValue(req))

    local anim = InAnimate:GetValue(req).Value

    local enterDur = InEnterEnd:GetValue(req).Value - InEnterStart:GetValue(req).Value
    local leaveDur = InLeaveEnd:GetValue(req).Value - InLeaveStart:GetValue(req).Value

    local d = (anim > 0 and leaveDur) or enterDur

    local img = InImage:GetSource(anim * d + d)

    OutImage:Set(req, img)
end
