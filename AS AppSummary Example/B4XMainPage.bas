﻿B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private AS_AppSummary1 As AS_AppSummary
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS AppSummary Example")
	
	AS_AppSummary1.SetTitleText("Welcome to"," Parcel ","!")
	
'	AS_AppSummary1.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",Null,"")
'	AS_AppSummary1.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",Null,"")
'	AS_AppSummary1.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",Null,"")
	
	AS_AppSummary1.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",AS_AppSummary1.FontToBitmap(Chr(0xE894),True,35,AS_AppSummary1.ItemIconProperties.Color),"")
	AS_AppSummary1.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",AS_AppSummary1.FontToBitmap(Chr(0xF02A),False,35,AS_AppSummary1.ItemIconProperties.Color),"")
	AS_AppSummary1.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",AS_AppSummary1.FontToBitmap(Chr(0xE7F4),True,35,AS_AppSummary1.ItemIconProperties.Color),"")

	AddNewFeatures_V260
	AddNewFeatures_V250

	AS_AppSummary1.ConfirmButtonText = "Start using Parcel"
	
	AS_AppSummary1.Refresh
	
End Sub

'V2.6.0
Private Sub AddNewFeatures_V260
	
	Dim NewFeature_V260_1 As AS_AppSummary_Item : NewFeature_V260_1.Initialize
	NewFeature_V260_1.Name = "V2.6.0 - Note Priorities [Premium]"
	NewFeature_V260_1.Description = "Assign priorities to your notes with Low, Medium, and High levels, each highlighted with distinct colors for better organization."
	AS_AppSummary1.AddItemAdvanced(NewFeature_V260_1)
	
	Dim NewFeature_V260_2 As AS_AppSummary_Item : NewFeature_V260_2.Initialize
	NewFeature_V260_2.Name = "V2.6.0 - Note Location"
	NewFeature_V260_2.Description = "Add location information to your notes, including address details. Automatically capture your current location when creating a note if enabled. Customize the displayed information via settings. Data is fetched using a geolocation API."
	AS_AppSummary1.AddItemAdvanced(NewFeature_V260_2)
	
End Sub

'V2.5.0
Private Sub AddNewFeatures_V250
	
	Dim NewFeature_V250_1 As AS_AppSummary_Item : NewFeature_V250_1.Initialize
	NewFeature_V250_1.Name = "V2.5.0 - FaceId group support [Premium]"
	NewFeature_V250_1.Description = "Enhance security by locking specific groups with Face ID. Access is granted only after a successful face scan."
	AS_AppSummary1.AddItemAdvanced(NewFeature_V250_1)
	
	Dim NewFeature_V250_2 As AS_AppSummary_Item : NewFeature_V250_2.Initialize
	NewFeature_V250_2.Name = "V2.5.0 - Favorite groups with icon [Premium]"
	NewFeature_V250_2.Description = "Mark your favorite groups with a heart icon for quick and easy identification."
	AS_AppSummary1.AddItemAdvanced(NewFeature_V250_2)
	
End Sub


#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	AS_AppSummary1.mBase.Height = Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom - 10dip
	AS_AppSummary1.Refresh
End Sub
#End If


Private Sub AS_AppSummary1_ConfirmButtonClick
	Log("ConfirmButtonClick")
End Sub

Private Sub AS_AppSummary1_ItemClicked(Item As AS_AppSummary_Item)
	Log("ItemClicked: " & Item.Name)
End Sub