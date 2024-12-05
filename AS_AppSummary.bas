B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-Add AddItemAdvanced
	-Add get ConfirmButton
	-Title Text BugFix
#End If

#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFF131416
#DesignerProperty: Key: TitleTextColor, DisplayName: Title Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: TitleColoredTextColor, DisplayName: Title Colored Text Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: ItemNameTextColor, DisplayName: Item Name Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemDescriptionTextColor, DisplayName: Item Description Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemIconColor, DisplayName: Item Icon Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: ConfirmButtonColor, DisplayName: Confirm Button Color, FieldType: Color, DefaultValue: 0xFF2D8879
#DesignerProperty: Key: ConfirmButtonTextColor, DisplayName: Confirm Button Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: ConfirmButtonClick

Sub Class_Globals
	
	Type AS_AppSummary_Item(Name As String, Description As String, Icon As B4XBitmap)
	Type AS_AppSummary_ItemIconProperties(Width As Float,Color As Int,BackgroundColor As Int,CornerRadius As Float,Alignment As String,SideGap As Float)
	
	Private g_ItemIconProperties As AS_AppSummary_ItemIconProperties
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private lst_Items As List
	
	Private xbblbl_Title As BBCodeView
	Private m_TextEngine As BCTextEngine
	
	Private xpnl_Items As B4XView
	Private xlbl_Start As B4XView
	
	Private m_TitleGap As Float = 20dip
	Private m_GapBetweenItems As Float = 30dip
	Private m_SideGap As Float = 20dip
	Private m_ItemsHasImage As Boolean = False
	
	Private m_BackgroundColor As Int
	Private m_TitleTextColor As Int
	Private m_TitleColoredTextColor As Int
	Private m_ItemNameTextColor As Int
	Private m_ItemDescriptionTextColor As Int
	Private m_ConfirmButtonColor As Int
	Private m_ConfirmButtonTextColor As Int
	
End Sub

Private Sub IniProps(Props As Map)
	
	m_BackgroundColor = xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	m_TitleTextColor = xui.PaintOrColorToColor(Props.Get("TitleTextColor"))
	m_TitleColoredTextColor = xui.PaintOrColorToColor(Props.Get("TitleColoredTextColor"))
	m_ItemNameTextColor = xui.PaintOrColorToColor(Props.Get("ItemNameTextColor"))
	m_ItemDescriptionTextColor = xui.PaintOrColorToColor(Props.Get("ItemDescriptionTextColor"))
	m_ConfirmButtonColor = xui.PaintOrColorToColor(Props.Get("ConfirmButtonColor"))
	m_ConfirmButtonTextColor = xui.PaintOrColorToColor(Props.Get("ConfirmButtonTextColor"))
	
	g_ItemIconProperties = CreateAS_AppSummary_ItemIconProperties(30dip,xui.PaintOrColorToColor(Props.Get("ItemIconColor")),xui.Color_Transparent,30dip/2,"Center",20dip)
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lst_Items.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 

	IniProps(Props)

	Dim xpnl_TitleBase As B4XView = xui.CreatePanel("")
	xpnl_TitleBase.SetLayoutAnimated(0,0,0,mBase.Width,2000dip)

	Dim m As Map
	m.Initialize
	
	xbblbl_Title.Initialize(Me,"")
	xbblbl_Title.DesignerCreateView(xpnl_TitleBase,Lbl,m)
	#If B4J
	xbblbl_Title.sv.As(ScrollPane).Style="-fx-background:transparent;-fx-background-color:transparent;"
	#End If
	m_TextEngine.Initialize(mBase)
	xbblbl_Title.TextEngine = m_TextEngine
	xbblbl_Title.Paragraph.Initialize

	xlbl_Start = CreateLabel("xlbl_Start")
	xpnl_Items = xui.CreatePanel("")

	mBase.AddView(xbblbl_Title.mBase,0,0,mBase.Width,100dip)
	mBase.AddView(xpnl_Items,0,0,mBase.Width,20dip)
	mBase.AddView(xlbl_Start,0,mBase.Height - 50dip,mBase.Width,50dip)
	
	xlbl_Start.Text = ""
	xlbl_Start.TextColor = xui.Color_Black
	xlbl_Start.Font = xui.CreateDefaultBoldFont(20)
	xlbl_Start.SetTextAlignment("CENTER","CENTER")
	xlbl_Start.SetColorAndBorder(xui.Color_White,0,0,10dip)
	
End Sub


Public Sub SetTitleText(Text1 As String,ColoredText As String,Text2 As String)
	xbblbl_Title.Text = $"[Alignment=Left][color=#${ColorToHex(m_TitleTextColor)}][TextSize=35][b]${Text1}[color=#${ColorToHex(m_TitleColoredTextColor)}]${ColoredText}[/color]${Text2}[/b][/TextSize][/color][/Alignment]"$
	xbblbl_Title.ParseAndDraw
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub AddItem(Name As String,Description As String,Icon As B4XBitmap)
	
	Dim Item As AS_AppSummary_Item
	Item.Initialize
	Item.Name = Name
	Item.Description = Description
	Item.Icon = Icon
	 
	AddItemIntern(Item)
	
End Sub

Public Sub AddItemAdvanced(Item As AS_AppSummary_Item)
	AddItemIntern(Item)
End Sub

Private Sub AddItemIntern(Item As AS_AppSummary_Item)
	
	If Item.Icon.IsInitialized Then m_ItemsHasImage = True
	 
	lst_Items.Add(Item)
	
	Dim xpnl_ItemBackground As B4XView = xui.CreatePanel("")
	xpnl_Items.AddView(xpnl_ItemBackground,0,0,mBase.Width,10dip)
	
	Dim xlbl_Name As B4XView = CreateLabel("")
	Dim xlbl_Description As B4XView = CreateLabel("")
	Dim xiv As B4XView = CreateImageView
	
	
	xpnl_ItemBackground.AddView(xlbl_Name,0,0,2dip,2dip)
	xpnl_ItemBackground.AddView(xlbl_Description,0,0,2dip,2dip)
	xpnl_ItemBackground.AddView(xiv,0,0,2dip,2dip)
	
End Sub


Public Sub ClearItems
	lst_Items.Clear
	xpnl_Items.RemoveAllViews
End Sub

Public Sub Refresh
	
	mBase.Color = m_BackgroundColor
	xbblbl_Title.mBase.Color = m_BackgroundColor
	xlbl_Start.TextColor = m_ConfirmButtonTextColor
	xlbl_Start.SetColorAndBorder(m_ConfirmButtonColor,0,0,10dip)
	
	xbblbl_Title.mBase.SetLayoutAnimated(0,m_SideGap,0,mBase.Width - m_SideGap*2,2000dip)
	xbblbl_Title.ParseAndDraw
	Dim ContentHeight As Int = Min(xbblbl_Title.Paragraph.Height / m_TextEngine.mScale + xbblbl_Title.Padding.Top + xbblbl_Title.Padding.Bottom, xbblbl_Title.mBase.Height)
	xbblbl_Title.mBase.SetLayoutAnimated(0,m_SideGap,0,mBase.Width - m_SideGap*2,ContentHeight)
	
	Dim SideGap4Icon As Float = IIf(m_ItemsHasImage,g_ItemIconProperties.Width + g_ItemIconProperties.SideGap,0)
	
	For i = 0 To lst_Items.Size -1
		
		Dim Item As AS_AppSummary_Item = lst_Items.Get(i)
		
		Dim xpnl_ItemBackground As B4XView = xpnl_Items.GetView(i)
	
		Dim xlbl_Name As B4XView = xpnl_ItemBackground.GetView(0)
		Dim xlbl_Description As B4XView = xpnl_ItemBackground.GetView(1)
		Dim xiv_Icon As B4XView = xpnl_ItemBackground.GetView(2)
		
		xlbl_Name.Text = Item.Name
		xlbl_Name.TextColor = m_ItemNameTextColor
		xlbl_Name.Font = xui.CreateDefaultBoldFont(20)
		xlbl_Name.SetTextAlignment("CENTER","LEFT")
		
		xlbl_Description.Text = Item.Description
		xlbl_Description.TextColor = m_ItemDescriptionTextColor
		xlbl_Description.Font = xui.CreateDefaultFont(17)
		xlbl_Description.SetTextAlignment("CENTER","LEFT")
		
	#If B4I
		xlbl_Description.As(Label).Multiline = True
	#End If
		
		xlbl_Name.Width = mBase.Width - m_SideGap*2 - SideGap4Icon
		xlbl_Description.Width = mBase.Width - m_SideGap*2 - SideGap4Icon

		xlbl_Name.SetLayoutAnimated(0,SideGap4Icon,0,xlbl_Name.Width,MeasureMultilineTextHeight(xlbl_Name))
		xlbl_Description.SetLayoutAnimated(0,SideGap4Icon,xlbl_Name.Height,xlbl_Description.Width,MeasureMultilineTextHeight(xlbl_Description))
		
		xpnl_ItemBackground.SetLayoutAnimated(0,m_SideGap,IIf(i=0,0,xpnl_Items.GetView(i-1).Top + xpnl_Items.GetView(i-1).Height),mBase.Width - m_SideGap*2,xlbl_Name.Height + xlbl_Description.Height + m_GapBetweenItems)
	
		If m_ItemsHasImage And Item.Icon.IsInitialized Then
			
			Select g_ItemIconProperties.Alignment
				Case "Top"
					xiv_Icon.SetLayoutAnimated(0,0,0,g_ItemIconProperties.Width,g_ItemIconProperties.Width)
				Case "Center"
					xiv_Icon.SetLayoutAnimated(0,0,(xpnl_ItemBackground.Height-m_GapBetweenItems)/2 - g_ItemIconProperties.Width/2,g_ItemIconProperties.Width,g_ItemIconProperties.Width)
				Case "Bottom"
					xiv_Icon.SetLayoutAnimated(0,0,(xpnl_ItemBackground.Height-m_GapBetweenItems) - g_ItemIconProperties.Width,g_ItemIconProperties.Width,g_ItemIconProperties.Width)
			End Select
			
			#If B4A OR B4I
			xiv_Icon.SetBitmap(Item.Icon)
			TintBmp(xiv_Icon,g_ItemIconProperties.Color)
			#Else
			xiv_Icon.SetBitmap(ChangeColorBasedOnAlphaLevel(Item.Icon,g_ItemIconProperties.Color))
			#End If
			
		End If
	
	Next
	
	xpnl_Items.Height = xpnl_Items.GetView(xpnl_Items.NumberOfViews -1).Top + xpnl_Items.GetView(xpnl_Items.NumberOfViews -1).Height
	xpnl_Items.Top = mBase.Height/2 - xpnl_Items.Height/2
	'xpnl_Items.Color = xui.Color_Red
	
	xbblbl_Title.mBase.Top = xpnl_Items.Top - m_TitleGap - xbblbl_Title.mBase.Height
	
	xlbl_Start.SetLayoutAnimated(0,m_SideGap,mBase.Height - 50dip,mBase.Width - m_SideGap*2,50dip)
	xbblbl_Title.Padding.Left = 0
	xbblbl_Title.ParseAndDraw
	'xbblbl_Title.mBase.Color = xui.Color_Red
End Sub

#Region Properties

'Call Refresh if you change something
Public Sub getItemIconProperties As AS_AppSummary_ItemIconProperties
	Return g_ItemIconProperties
End Sub

Public Sub getConfirmButton As B4XView
	Return xlbl_Start
End Sub

Public Sub setConfirmButtonText(Text As String)
	xlbl_Start.Text = Text
End Sub

'Call Refresh if you change something
Public Sub setConfirmButtonTextColor(Color As Int)
	m_ConfirmButtonTextColor = Color
End Sub

Public Sub getConfirmButtonTextColor As Int
	Return m_ConfirmButtonTextColor
End Sub

'Call Refresh if you change something
Public Sub setConfirmButtonColor(Color As Int)
	m_ConfirmButtonColor = Color
End Sub

Public Sub getConfirmButtonColor As Int
	Return m_ConfirmButtonColor
End Sub

'Call Refresh if you change something
Public Sub setItemDescriptionTextColor(Color As Int)
	m_ItemDescriptionTextColor = Color
End Sub

Public Sub getItemDescriptionTextColor As Int
	Return m_ItemDescriptionTextColor
End Sub

'Call Refresh if you change something
Public Sub setItemNameTextColor(Color As Int)
	m_ItemNameTextColor = Color
End Sub

Public Sub getItemNameTextColor As Int
	Return m_ItemNameTextColor
End Sub

'Call SetTitleText if you change this property
Public Sub setTitleColoredTextColor(Color As Int)
	m_TitleColoredTextColor = Color
End Sub

Public Sub getTitleColoredTextColor As Int
	Return m_TitleColoredTextColor
End Sub

'Call SetTitleText if you change this property
Public Sub setTitleTextColor(Color As Int)
	m_TitleTextColor = Color
End Sub

Public Sub getTitleTextColor As Int
	Return m_TitleTextColor
End Sub

'Call Refresh if you change something
Public Sub setBackgroundColor(Color As Int)
	m_BackgroundColor = Color
End Sub

Public Sub getBackgroundColor As Int
	Return m_BackgroundColor
End Sub

#End Region

#Region ViewEvents

#If B4J
Private Sub xlbl_Start_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_Start_Click
#End If
	ConfirmButtonClick
End Sub

#End Region

#Region Events

Private Sub ConfirmButtonClick
	If xui.SubExists(mCallBack,mEventName & "_ConfirmButtonClick",0) Then
		CallSub(mCallBack,mEventName & "_ConfirmButtonClick")
	End If
End Sub

#End Region

#Region Functions

Private Sub CreateImageView As B4XView
	Dim iv As ImageView
	iv.Initialize("")
	Return iv
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub MeasureMultilineTextHeight(xLabel As B4XView) As Double
    #If B4J
	'https://www.b4x.com/android/forum/threads/measure-multiline-text-height.84331/#content
    Dim jo As JavaObject = Me
    Return jo.RunMethod("MeasureMultilineTextHeight", Array(xLabel.Font, xLabel.Text, xLabel.Width))
    #Else if B4A
    Dim su As StringUtils
    Return su.MeasureMultilineTextHeight(xLabel,xLabel.Text)
    #Else if B4I
	Dim tmpLabel As Label
	tmpLabel.Initialize("")
	tmpLabel.Font = xLabel.Font
	tmpLabel.Width = xLabel.Width
	tmpLabel.Text = xLabel.Text
	tmpLabel.Multiline = True
	tmpLabel.SizeToFit
	Return tmpLabel.Height
    #End IF
End Sub

#If B4J
#if Java
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javafx.scene.text.Font;
import javafx.scene.text.TextBoundsType;
public static double MeasureMultilineTextHeight(Font f, String text, double width) throws Exception {
  Method m = Class.forName("com.sun.javafx.scene.control.skin.Utils").getDeclaredMethod("computeTextHeight",
  Font.class, String.class, double.class, TextBoundsType.class);
  m.setAccessible(true);
  return (Double)m.invoke(null, f, text, width, TextBoundsType.LOGICAL_VERTICAL_CENTER);
  }
#End If
#End If

'int ot argb
Private Sub GetARGB(Color As Int) As Int()'ignore
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#If B4A OR B4I
Private Sub TintBmp(img As ImageView, color As Int)
	'If m_ColorIcons = True Then
	#If B4I
	Dim NaObj As NativeObject = Me
	NaObj.RunMethod("BmpColor::",Array(img,NaObj.ColorToUIColor(color)))
	#Else if B4J
	If color = 0 Then
		Dim jiv As JavaObject = img
		jiv.RunMethod("setClip",Array(Null))
		jiv.RunMethod("setEffect", Array(Null))
		Return
	End If
	Dim fx As JFX
	color = fx.Colors.To32Bit(fx.Colors.rgb(GetARGB(color)(1),GetARGB(color)(2),GetARGB(color)(3)))
	Dim monochrome,effect,mode,tint As JavaObject
	monochrome.InitializeNewInstance("javafx.scene.effect.ColorAdjust", Null)
	monochrome.RunMethod("setSaturation", Array(-1.0))
	effect.InitializeNewInstance("javafx.scene.effect.Blend",Array(mode.InitializeStatic("javafx.scene.effect.BlendMode").GetField("SCREEN"),monochrome,tint.InitializeNewInstance("javafx.scene.effect.ColorInput",Array(0.0,0.0,img.PrefWidth,img.PrefHeight,fx.Colors.From32Bit(color)))))
	Dim jiv As JavaObject = img
	Dim imgt As ImageView
	imgt.Initialize("")
	imgt.SetImage(img.GetImage)
	imgt.SetSize(img.PrefWidth,img.PrefHeight)
	jiv.RunMethod("setClip",Array(imgt))
	jiv.RunMethod("setEffect", Array(effect))
	
	#Else If B4A
		Dim jo As JavaObject=img
		'jo.RunMethod("setImageBitmap",Array(img.Bitmap))
	'jo.RunMethod("setColorFilter",Array(Colors.Transparent))
		jo.RunMethod("setColorFilter",Array(Colors.rgb(GetARGB(color)(1),GetARGB(color)(2),GetARGB(color)(3))))
	
	#End If
	'End If
	
End Sub
#End If


#If B4J
Sub ChangeColorBasedOnAlphaLevel(bmp As B4XBitmap, NewColor As Int) As B4XBitmap
	'If m_ColorIcons = True Then
		Dim bc As BitmapCreator
		bc.Initialize(bmp.Width, bmp.Height)
		bc.CopyPixelsFromBitmap(bmp)
		Dim a1, a2 As ARGBColor
		bc.ColorToARGB(NewColor, a1)
		For y = 0 To bc.mHeight - 1
			For x = 0 To bc.mWidth - 1
				bc.GetARGB(x, y, a2)
				If a2.a > 0 Then
					a2.r = a1.r
					a2.g = a1.g
					a2.b = a1.b
					bc.SetARGB(x, y, a2)
				End If
			Next
		Next
		Return bc.Bitmap
'	Else
'		Return bmp
'	End If
End Sub
#end If

#If OBJC
- (void)BmpColor: (UIImageView*) theImageView :(UIColor*) Color{
theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
[theImageView setTintColor:Color];
}
#end if

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Private Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Dim Hex As String = bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
	If Hex.Length > 6 Then Hex = Hex.SubString(Hex.Length - 6)
	Return Hex
End Sub

#End Region

Public Sub CreateAS_AppSummary_ItemIconProperties (Width As Float, Color As Int, BackgroundColor As Int, CornerRadius As Float, Alignment As String, SideGap As Float) As AS_AppSummary_ItemIconProperties
	Dim t1 As AS_AppSummary_ItemIconProperties
	t1.Initialize
	t1.Width = Width
	t1.Color = Color
	t1.BackgroundColor = BackgroundColor
	t1.CornerRadius = CornerRadius
	t1.Alignment = Alignment
	t1.SideGap = SideGap
	Return t1
End Sub