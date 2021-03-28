
StatTab = Protection
MainTab = Player
VehicleTab = VehOp
PlaylistTab = VSpawn
ManualTab = PlayerData
MiscTab = Struct
------------------------------------------HEIST OPTION----------------------------------------------------------

----------------------------------------------HEIST OPTION END--------------------------------------------------
--MainSliderInput = CEEdit2
--ListSlider = CEListBox1
--InputLevel = CEEdit3
--RIDSpooferInput = CEEdit4
--RIDSpooferSet = CEEdit8
--ScriptEventData = CheckListBox1

function ShowNotification(Information)
    local function DragNotification(sender, button, x, y)
        Notification.DragNow()
     end
     
    local function DragNotification(sender, button, x, y)
        Notification.DragNow()
    end
     
     --
     ----
     ---- FORM: Notification
     ------------------------------
     Notification = createForm()
     Notification.Tag = 0
     Notification.Left = 3
     Notification.Height = 240
     Notification.Hint = ''
     Notification.Top = 5
     Notification.Width = 320
     Notification.HelpType = htContext
     Notification.HelpKeyword = ''
     Notification.HelpContext = 0
     Notification.Align = alNone
     Notification.AllowDropFiles = false
     Notification.AlphaBlend = true
     Notification.AlphaBlendValue = 200
     Notification.Anchors = '[akTop,akLeft]'
     Notification.AutoScroll = false
     Notification.AutoSize = false
     Notification.BiDiMode = bdLeftToRight
     Notification.BorderIcons = '[]'
     Notification.BorderStyle = bsNone
     Notification.BorderWidth = 0
     Notification.Caption = 'Notification'
     Notification.ClientHeight = 240
     Notification.ClientWidth = 320
     Notification.Color = -2147483641
     Notification.Constraints.MaxWidth = 0
     Notification.Constraints.MinHeight = 0
     Notification.Constraints.MinWidth = 0
     Notification.DefaultMonitor = dmActiveForm
     Notification.DockSite = false
     Notification.DragKind = dkDrag
     Notification.DragMode = dmManual
     Notification.Font.Color = 536870912
     Notification.Font.Height = 0
     Notification.Font.Name = 'default'
     Notification.Font.Orientation = 0
     Notification.Font.Pitch = fpDefault
     Notification.Font.Quality = fqDefault
     Notification.Font.Size = 0
     Notification.Font.Style = '[]'
     Notification.FormStyle = fsSystemStayOnTop
     Notification.KeyPreview = false
     Notification.ParentBiDiMode = true
     Notification.ParentFont = false
     Notification.PixelsPerInch = 96
     Notification.Position = poDesigned
     Notification.ShowInTaskBar = stAlways
     Notification.Visible = true
     Notification.WindowState = wsNormal
     Notification.DoNotSaveInTable = false
     ------------------------------
     ---- Notification : Components
     ------------------------------
     --
     ---- Info
     --------------------
     Info = createMemo(Notification)
     Info.Tag = 0
     Info.Left = -1
     Info.Height = 238
     Info.Hint = ''
     Info.Top = 0
     Info.Width = 318
     Info.HelpType = htContext
     Info.HelpKeyword = ''
     Info.HelpContext = 0
     Info.Align = alNone
     Info.Alignment = taLeftJustify
     Info.Anchors = '[akTop,akLeft]'
     Info.BidiMode = bdLeftToRight
     Info.BorderSpacing.Top = 0
     Info.BorderStyle = bsSingle
     Info.CharCase = ecNormal
     Info.Color = -2147483647
     Info.Constraints.MaxWidth = 0
     Info.Constraints.MinHeight = 0
     Info.Constraints.MinWidth = 0
     Info.DragCursor = -12
     Info.DragKind = dkDrag
     Info.DragMode = dmManual
     Info.Enabled = true
     Info.Font.Color = 46848
     Info.Font.Height = 0
     Info.Font.Name = 'default'
     Info.Font.Orientation = 0
     Info.Font.Pitch = fpDefault
     Info.Font.Quality = fqDefault
     Info.Font.Size = 12
     Info.Font.Style = '[]'
     Info.HideSelection = true
     Info.MaxLength = 0
     Info.ParentBidiMode = true
     Info.ParentColor = false
     Info.ParentFont = false
     Info.ParentShowHint = true
     Info.ReadOnly = true
     Info.ScrollBars = ssNone
     Info.ShowHint = false
     Info.TabOrder = 0
     Info.TabStop = true
     Info.Visible = true
     Info.WordWrap = true
     Info.SelStart = 0
     Info.Lines.Text = Information
     --------------------
     ------------------------------
     ---- END FORM: Notification
     ---- 
     --
      
end
