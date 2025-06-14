//+------------------------------------------------------------------+
//|                                                   IconButton.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
//+------------------------------------------------------------------+
//| Class for Creating an Icon Button                                |
//+------------------------------------------------------------------+
class CIconButton : public CElement
  {
private:
   //--- Object for creating a button
   CButton           m_button;
   CBmpLabel         m_icon;
   CLabel            m_label;
   //--- Button properties:
   //    Size and priority of left mouse click
   int               m_button_x_size;
   int               m_button_y_size;
   int               m_button_zorder;
   //--- Background color in different modes
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   color             m_back_color_array[];
   //--- Frame color
   color             m_border_color;
   color             m_border_color_off;
   //--- Icons for the button in active, blocked and pressed states
   string            m_icon_file_on;
   string            m_icon_file_off;
   string            m_icon_file_pressed_on;
   string            m_icon_file_pressed_off;
   //--- Icon margins
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- Text and margins of the text label
   string            m_label_text;
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Text label color in different modes
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   color             m_label_color_array[];
   //--- General priority of unclickable objects
   int               m_zorder;
   //--- Mode of two button states
   bool              m_two_state;
   //--- Available/blocked
   bool              m_button_state;
   //--- The icon only mode if the button is composed only of the BmpLabel object
   bool              m_only_icon;
   //---
public:
                     CIconButton(void);
                    ~CIconButton(void);
   //--- Methods for creating a button
   bool              CreateIconButton(const long chart_id,const int subwin,const string button_text,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateButton(void);
   bool              CreateIcon(void);
   bool              CreateLabel(void);
   //---
public:
   //--- (1) Sets the button mode, (2) sets the icon only mode, (3) button state (pressed/released)
   void              TwoState(const bool flag)                  { m_two_state=flag;                  }
   void              OnlyIcon(const bool flag)                  { m_only_icon=flag;                  }
   bool              IsPressed(void)                      const { return(m_button.State());          }
   void              IsPressed(const bool state);
   //--- (1) Button text, (2) button size, (3) general state of the control (available/blocked)
   string            Text(void)                           const { return(m_label.Description());     }
   void              Text(const string text)                    { m_label.Description(text);         }
   void              ButtonXSize(const int x_size)              { m_button_x_size=x_size;            }
   void              ButtonYSize(const int y_size)              { m_button_y_size=y_size;            }
   bool              ButtonState(void)                    const { return(m_button_state);            }
   void              ButtonState(const bool state);
   //--- Icon margins
   void              IconXGap(const int x_gap)                  { m_icon_x_gap=x_gap;                }
   void              IconYGap(const int y_gap)                  { m_icon_y_gap=y_gap;                }
   //--- Button background colors
   void              BackColor(const color clr)                 { m_back_color=clr;                  }
   void              BackColorOff(const color clr)              { m_back_color_off=clr;              }
   void              BackColorHover(const color clr)            { m_back_color_hover=clr;            }
   void              BackColorPressed(const color clr)          { m_back_color_pressed=clr;          }
   //--- Setting up the color of the button frame
   void              BorderColor(const color clr)               { m_border_color=clr;                }
   void              BorderColorOff(const color clr)            { m_border_color_off=clr;            }
   //--- Text label margins
   void              LabelXGap(const int x_gap)                 { m_label_x_gap=x_gap;               }
   void              LabelYGap(const int y_gap)                 { m_label_y_gap=y_gap;               }
   //--- Setting the color of the button text
   void              LabelColor(const color clr)                { m_label_color=clr;                 }
   void              LabelColorOff(const color clr)             { m_label_color_off=clr;             }
   void              LabelColorHover(const color clr)           { m_label_color_hover=clr;           }
   void              LabelColorPressed(const color clr)         { m_label_color_pressed=clr;         }
   //--- Setting icons for the button in the pressed, active and blocked states
   void              IconFileOn(const string file_path);
   void              IconFileOff(const string file_path);
   void              IconFilePressedOn(const string file_path);
   void              IconFilePressedOff(const string file_path);

   //--- Changing the color of the element
   void              ChangeObjectsColor(void);
   //---
public:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Timer
   virtual void      OnEventTimer(void);
   //--- Moving the element
   virtual void      Moving(const int x,const int y,const bool moving_mode=false);
   //--- (1) Show, (2) hide, (3) reset, (4) delete
   virtual void      Show(void);
   virtual void      Hide(void);
   virtual void      Reset(void);
   virtual void      Delete(void);
   //--- (1) Set, (2) reset priorities of the left mouse button click
   virtual void      SetZorders(void);
   virtual void      ResetZorders(void);
   //--- Zero the color
   virtual void      ResetColors(void);
   //---
private:
   //--- Handling the pressing of a button
   bool              OnClickButton(const string clicked_object);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIconButton::CIconButton(void) : m_icon_x_gap(4),
                                 m_icon_y_gap(3),
                                 m_label_x_gap(25),
                                 m_label_y_gap(4),
                                 m_icon_file_on(""),
                                 m_icon_file_off(""),
                                 m_icon_file_pressed_on(""),
                                 m_icon_file_pressed_off(""),
                                 m_button_state(true),
                                 m_two_state(false),
                                 m_only_icon(false),
                                 m_button_y_size(18),
                                 m_back_color(clrGainsboro),
                                 m_back_color_off(clrLightGray),
                                 m_back_color_hover(C'193,218,255'),
                                 m_back_color_pressed(C'190,190,200'),
                                 m_border_color(C'150,170,180'),
                                 m_border_color_off(C'178,195,207'),
                                 m_label_color(clrBlack),
                                 m_label_color_off(clrDarkGray),
                                 m_label_color_hover(clrBlack),
                                 m_label_color_pressed(clrBlack)
  {
//--- Store the name of the element class in the base class  
   CElementBase::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_zorder        =0;
   m_button_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconButton::~CIconButton(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CIconButton::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling of the cursor movement event
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Leave, if the control is hidden
      if(!CElementBase::IsVisible())
         return;
      //--- Leave, if numbers of subwindows do not match
      if(!CElementBase::CheckSubwindowNumber())
         return;
      //--- Checking the focus over elements
      CElementBase::CheckMouseFocus();
      m_icon.MouseFocus(m_mouse.X()>m_icon.X() && m_mouse.X()<m_icon.X2() && m_mouse.Y()>m_icon.Y() && m_mouse.Y()<m_icon.Y2());
      //--- Leave, if the form is blocked
      if(m_wnd.IsLocked())
         return;
      //--- Leave, if the left mouse button is released
      if(!m_mouse.LeftButtonState())
         return;
      //--- Leave, if the button is blocked
      if(!m_button_state)
         return;
      //--- If there is no focus
      if(!CElementBase::MouseFocus())
        {
         //--- If the button is released
         if(!m_button.State())
            m_button.BackColor(m_back_color);
         //---
         return;
        }
      //--- If there is a focus
      else
        {
         m_label.Color(m_label_color_pressed);
         m_button.BackColor(m_back_color_pressed);
         return;
        }
      //---
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CIconButton::OnEventTimer(void)
  {
//--- If this is a drop-down element
   if(CElementBase::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- If the form and the button are not blocked
      if(!m_wnd.IsLocked() && m_button_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Create "Button" control                                          |
//+------------------------------------------------------------------+
bool CIconButton::CreateIconButton(const long chart_id,const int subwin,const string button_text,const int x_gap,const int y_gap)
  {
//--- Exit if there is no pointer to the form
   if(!CElement::CheckWindowPointer())
      return(false);
//--- Initializing variables
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_x          =CElement::CalculateX(x_gap);
   m_y          =CElement::CalculateY(y_gap);
   m_label_text =button_text;
//--- Margins from the edge
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
//--- Creating a button
   if(!CreateButton())
      return(false);
   if(!CreateIcon())
      return(false);
   if(!CreateLabel())
      return(false);
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the button background                                    |
//+------------------------------------------------------------------+
bool CIconButton::CreateButton(void)
  {
//--- Leave, if the icon only mode is enabled
   if(m_only_icon)
      return(true);
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_icon_button_"+(string)CElementBase::Id();
//--- Set up a button
   if(!m_button.Create(m_chart_id,name,m_subwin,m_x,m_y,m_button_x_size,m_button_y_size))
      return(false);
//--- Set properties
   m_button.Font(CElementBase::Font());
   m_button.FontSize(CElementBase::FontSize());
   m_button.Color(m_back_color);
   m_button.Description("");
   m_button.BorderColor(m_border_color);
   m_button.BackColor(m_back_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_button_zorder);
   m_button.Tooltip("\n");
//--- Store the size
   CElementBase::XSize(m_button_x_size);
   CElementBase::YSize(m_button_y_size);
//--- Margins from the edge
   m_button.XGap(CElement::CalculateXGap(m_x));
   m_button.YGap(CElement::CalculateYGap(m_y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the button icon                                          |
//+------------------------------------------------------------------+
bool CIconButton::CreateIcon(void)
  {
//--- If the icon only mode disabled
   if(!m_only_icon)
     {
      //--- Leave, if the icon for the button is not required
      if(m_icon_file_on=="" || m_icon_file_off=="")
         return(true);
     }
//--- If the icon only mode is enabled 
   else
     {
      //--- If the icon has not been defined, print the message and leave
      if(m_icon_file_on=="" || m_icon_file_off=="")
        {
         ::Print(__FUNCTION__," > The icon must be defined in the \"Icon only\" mode.");
         return(false);
        }
     }
//--- Forming the object name
   string name="";
   if(m_index==WRONG_VALUE)
      name=CElementBase::ProgramName()+"_icon_button_bmp_"+(string)CElementBase::Id();
   else
      name=CElementBase::ProgramName()+"_icon_button_bmp_"+(string)CElementBase::Index()+"__"+(string)CElementBase::Id();
//--- Coordinates
   int x =(!m_only_icon)? m_x+m_icon_x_gap : m_x;
   int y =(!m_only_icon)? m_y+m_icon_y_gap : m_y;
//--- Set up the icon
   if(!m_icon.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_icon.BmpFileOn("::"+m_icon_file_on);
   m_icon.BmpFileOff("::"+m_icon_file_off);
   m_icon.State(true);
   m_icon.Corner(m_corner);
   m_icon.GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icon.Selectable(false);
   m_icon.Z_Order((!m_only_icon)? m_zorder : m_button_zorder);
   m_icon.Tooltip((!m_only_icon)? "\n" : m_label_text);
//--- Store coordinates
   m_icon.X(x);
   m_icon.Y(y);
//--- Store the size
   m_icon.XSize(m_icon.X_Size());
   m_icon.YSize(m_icon.Y_Size());
//--- Margins from the edge
   m_icon.XGap(CElement::CalculateXGap(x));
   m_icon.YGap(CElement::CalculateYGap(y));
//--- If the icon only mode is enabled
   if(m_only_icon)
     {
      CElementBase::X(x);
      CElementBase::Y(y);
      CElementBase::XSize(m_icon.X_Size());
      CElementBase::YSize(m_icon.Y_Size());
     }
//--- Store the object pointer
   CElementBase::AddToArray(m_icon);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the button text                                          |
//+------------------------------------------------------------------+
bool CIconButton::CreateLabel(void)
  {
//--- Leave, if the icon only mode is enabled
   if(m_only_icon)
      return(true);
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_icon_button_lable_"+(string)CElementBase::Id();
//--- Coordinates
   int x =m_x+m_label_x_gap;
   int y =m_y+m_label_y_gap;
//--- Set the text label
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_label.Description(m_label_text);
   m_label.Font(CElementBase::Font());
   m_label.FontSize(CElementBase::FontSize());
   m_label.Color(m_label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- Margins from the edge
   m_label.XGap(CElement::CalculateXGap(x));
   m_label.YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Setting the button state - pressed/released                      |
//+------------------------------------------------------------------+
void CIconButton::IsPressed(const bool state)
  {
//--- Leave, if the button is blocked
   if(!m_button_state)
      return;
//--- Leave, if the two-state mode is disabled for the button
   if(!m_two_state)
      return;
//--- Setting the state and the corresponding color
   m_button.State(state);
   m_button.Color((state)? m_label_color_pressed : m_label_color);
   m_button.BackColor((state)? m_back_color_pressed : m_back_color);
   if(state)
      CElementBase::InitColorArray(m_back_color_pressed,m_back_color_pressed,m_back_color_array);
   else
      CElementBase::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
//--- Leave, if the icon is not set
   if(m_icon_file_pressed_on=="")
      return;
//--- Set the icon
   if(state)
     {
      m_icon.BmpFileOn("::"+m_icon_file_pressed_on);
      m_icon.BmpFileOff("::"+m_icon_file_pressed_off);
     }
   else
     {
      m_icon.BmpFileOn("::"+m_icon_file_on);
      m_icon.BmpFileOff("::"+m_icon_file_off);
     }
  }
//+------------------------------------------------------------------+
//| Set icon for the "ON" state                                      |
//+------------------------------------------------------------------+
void CIconButton::IconFileOn(const string file_path)
  {
   m_icon_file_on=file_path;
   m_icon.BmpFileOn("::"+file_path);
  }
//+------------------------------------------------------------------+
//| Set icon for the "OFF" state                                     |
//+------------------------------------------------------------------+
void CIconButton::IconFileOff(const string file_path)
  {
   m_icon_file_off=file_path;
   m_icon.BmpFileOff("::"+file_path);
  }
//+------------------------------------------------------------------+
//| Set icon for the pressed "ON" state                              |
//+------------------------------------------------------------------+
void CIconButton::IconFilePressedOn(const string file_path)
  {
//--- Leave, if the two-state mode is disabled for the button
   if(!m_two_state)
      return;
//--- Store the path to the picture
   m_icon_file_pressed_on=file_path;
//--- Immediately determine if the button is pressed
   if(m_button.State())
      m_icon.BmpFileOn("::"+file_path);
  }
//+------------------------------------------------------------------+
//| Set icon for the pressed "OFF" state                             |
//+------------------------------------------------------------------+
void CIconButton::IconFilePressedOff(const string file_path)
  {
//--- Leave, if the two-state mode is disabled for the button
   if(!m_two_state)
      return;
//--- Store the path to the picture
   m_icon_file_pressed_off=file_path;
//--- Immediately determine if the button is pressed
   if(m_button.State())
      m_icon.BmpFileOff("::"+file_path);
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CIconButton::Moving(const int x,const int y,const bool moving_mode=false)
  {
//--- Leave, if the control is hidden
   if(!CElementBase::IsVisible())
      return;
//--- If the management is delegated to the window, identify its location
   if(!moving_mode)
      if(m_wnd.ClampingAreaMouse()!=PRESSED_INSIDE_HEADER)
         return;
//--- If the anchored to the right
   if(m_anchor_right_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::X(m_wnd.X2()-XGap());
      //--- Storing coordinates in the fields of the objects
      m_button.X(m_wnd.X2()-m_button.XGap());
      m_icon.X(m_wnd.X2()-m_icon.XGap());
      m_label.X(m_wnd.X2()-m_label.XGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::X(x+XGap());
      //--- Storing coordinates in the fields of the objects
      m_button.X(x+m_button.XGap());
      m_icon.X(x+m_icon.XGap());
      m_label.X(x+m_label.XGap());
     }
//--- If the anchored to the bottom
   if(m_anchor_bottom_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(m_wnd.Y2()-YGap());
      //--- Storing coordinates in the fields of the objects
      m_button.Y(m_wnd.Y2()-m_button.YGap());
      m_icon.Y(m_wnd.Y2()-m_icon.YGap());
      m_label.Y(m_wnd.Y2()-m_label.YGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::Y(y+YGap());
      //--- Storing coordinates in the fields of the objects
      m_button.Y(y+m_button.YGap());
      m_icon.Y(y+m_icon.YGap());
      m_label.Y(y+m_label.YGap());
     }
//--- Updating coordinates of graphical objects
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_icon.X_Distance(m_icon.X());
   m_icon.Y_Distance(m_icon.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
  }
//+------------------------------------------------------------------+
//| Shows the button                                                 |
//+------------------------------------------------------------------+
void CIconButton::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElementBase::IsVisible())
      return;
//--- Make all the objects visible
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Visible state
   CElementBase::IsVisible(true);
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Hides the button                                                 |
//+------------------------------------------------------------------+
void CIconButton::Hide(void)
  {
//--- Leave, if the control is hidden
   if(!CElementBase::IsVisible())
      return;
//--- Hide all objects
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Visible state
   CElementBase::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CIconButton::Reset(void)
  {
//--- Leave, if this is a drop-down element
   if(CElementBase::IsDropdown())
      return;
//--- Hide and show
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Remove                                                         |
//+------------------------------------------------------------------+
void CIconButton::Delete(void)
  {
//--- Removing objects
   m_button.Delete();
   m_icon.Delete();
   m_label.Delete();
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::MouseFocus(false);
   CElementBase::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CIconButton::SetZorders(void)
  {
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_button_zorder);
   m_icon.Z_Order((!m_only_icon)? m_zorder : m_button_zorder);
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CIconButton::ResetZorders(void)
  {
   m_button.Z_Order(-1);
   m_icon.Z_Order(-1);
   m_label.Z_Order(-1);
//--- 
   m_icon.MouseFocus(false);
   ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Reset the color                                                  |
//+------------------------------------------------------------------+
void CIconButton::ResetColors(void)
  {
//--- Leave, if this is the two-state mode and the button is pressed
   if(m_two_state && m_button_state)
      return;
//--- Zero the color
   m_button.BackColor(m_back_color);
//--- Zero the focus
   m_button.MouseFocus(false);
   CElementBase::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CIconButton::ChangeObjectsColor(void)
  {
   if(m_only_icon)
      m_icon.State(m_icon.MouseFocus());
//--- Leave, if the element is blocked
   if(!m_button_state)
      return;
//---
   CElementBase::ChangeObjectColor(m_button.Name(),CElementBase::MouseFocus(),OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_back_color_array);
   CElementBase::ChangeObjectColor(m_label.Name(),CElementBase::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| Changing the button state                                        |
//+------------------------------------------------------------------+
void CIconButton::ButtonState(const bool state)
  {
   m_button_state=state;
//--- Set colors corresponding to the current state to the object
   m_icon.State(state);
//---
   if(m_button.State())
     {
      m_label.Color((state)? m_label_color_pressed : m_label_color_off);
      m_button.State(true);
      m_button.BackColor((state)? m_back_color_pressed : m_back_color_off);
      m_button.BorderColor((state)? m_border_color : m_border_color_off);
     }
   else
     {
      m_label.Color((state)? m_label_color : m_label_color_off);
      m_button.State(false);
      m_button.BackColor((state)? m_back_color : m_back_color_off);
      m_button.BorderColor((state)? m_border_color : m_border_color_off);
     }
  }
//+------------------------------------------------------------------+
//| Pressing the button                                              |
//+------------------------------------------------------------------+
bool CIconButton::OnClickButton(const string clicked_object)
  {
//--- If the icon only mode is disabled
   if(!m_only_icon)
     {
      //--- Leave, if it has a different object name
      if(m_button.Name()!=clicked_object)
         return(false);
      //--- Leave, if the button is blocked
      if(!m_button_state)
        {
         m_button.State(false);
         return(false);
        }
      //--- if this is a self-releasing button
      if(!m_two_state)
        {
         m_button.State(false);
         m_button.BackColor(m_back_color);
         m_label.Color(m_label_color);
        }
      //--- if this is a button with two states
      else
        {
         if(m_button.State())
           {
            m_button.State(true);
            m_label.Color(m_label_color_pressed);
            m_button.BackColor(m_back_color_pressed);
            CElementBase::InitColorArray(m_back_color_pressed,m_back_color_pressed,m_back_color_array);
            //--- If icon for the pressed state is set
            if(m_icon_file_pressed_on!="")
              {
               m_icon.BmpFileOn("::"+m_icon_file_pressed_on);
               m_icon.BmpFileOff("::"+m_icon_file_pressed_off);
              }
           }
         else
           {
            m_button.State(false);
            m_label.Color(m_label_color);
            m_button.BackColor(m_back_color);
            m_icon.BmpFileOn("::"+m_icon_file_on);
            m_icon.BmpFileOff("::"+m_icon_file_off);
            CElementBase::InitColorArray(m_back_color,m_back_color_hover,m_back_color_array);
           }
        }
     }
//--- If the icon only mode enabled  
   else
     {
      //--- Leave, if it has a different object name
      if(m_icon.Name()!=clicked_object)
         return(false);
      //--- Set the state to On
      m_icon.State(true);
     }
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElementBase::Id(),CElementBase::Index(),m_label_text);
   return(true);
  }
//+------------------------------------------------------------------+
