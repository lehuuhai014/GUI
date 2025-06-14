//+------------------------------------------------------------------+
//|                                             IconButtonsGroup.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
//+------------------------------------------------------------------+
//| Class for creating groups of radio buttons                       |
//+------------------------------------------------------------------+
class CIconButtonsGroup : public CElement
  {
private:
   //--- Object for creating a button
   CButton           m_buttons[];
   CBmpLabel         m_icons[];
   CLabel            m_labels[];
   //--- Gradients of text labels
   struct IconButtonsGradients
     {
      color             m_back_color_array[];
      color             m_label_color_array[];
     };
   IconButtonsGradients m_icon_buttons_total[];
   //--- Button properties:
   //    Arrays for unique properties of buttons
   bool              m_buttons_state[];
   int               m_buttons_x_gap[];
   int               m_buttons_y_gap[];
   string            m_buttons_text[];
   int               m_buttons_width[];
   string            m_icon_file_on[];
   string            m_icon_file_off[];
   //--- Height of buttons
   int               m_buttons_y_size;
   //--- Background color in different modes
   color             m_back_color;
   color             m_back_color_off;
   color             m_back_color_hover;
   color             m_back_color_pressed;
   //--- Frame color
   color             m_border_color;
   color             m_border_color_off;
   //--- Icon margins
   int               m_icon_x_gap;
   int               m_icon_y_gap;
   //--- Text label margins
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Text label color in different modes
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_pressed;
   //--- (1) Text and (2) index of the highlighted button
   string            m_selected_button_text;
   int               m_selected_button_index;
   //--- General priority of unclickable objects
   int               m_zorder;
   //--- Priority of left mouse click
   int               m_buttons_zorder;
   //--- Available/blocked
   bool              m_icon_buttons_state;
   //---
public:
                     CIconButtonsGroup(void);
                    ~CIconButtonsGroup(void);
   //--- Methods for creating a button
   bool              CreateIconButtonsGroup(const long chart_id,const int subwin,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateButton(const int index);
   bool              CreateIcon(const int index);
   bool              CreateLabel(const int index);
   //---
public:
   //--- (1) the height of buttons, (2) the number of buttons, (3) general state of the button (available/blocked)
   void              ButtonsYSize(const int y_size)               { m_buttons_y_size=y_size;         }
   int               IconButtonsTotal(void)                 const { return(::ArraySize(m_icons));    }
   bool              IconButtonsState(void)                 const { return(m_icon_buttons_state);    }
   void              IconButtonsState(const bool state);
   //--- Button background colors
   void              BackColor(const color clr)                   { m_back_color=clr;                }
   void              BackColorOff(const color clr)                { m_back_color_off=clr;            }
   void              BackColorHover(const color clr)              { m_back_color_hover=clr;          }
   void              BackColorPressed(const color clr)            { m_back_color_pressed=clr;        }
   //--- Setting up the color of the button frame
   void              BorderColor(const color clr)                 { m_border_color=clr;              }
   void              BorderColorOff(const color clr)              { m_border_color_off=clr;          }
   //--- Icon margins
   void              IconXGap(const int x_gap)                    { m_icon_x_gap=x_gap;              }
   void              IconYGap(const int y_gap)                    { m_icon_y_gap=y_gap;              }
   //--- Text label margins
   void              LabelXGap(const int x_gap)                   { m_label_x_gap=x_gap;             }
   void              LabelYGap(const int y_gap)                   { m_label_y_gap=y_gap;             }
   //--- Returns (1) the text and (2) index of the highlighted button
   string            SelectedButtonText(void)               const { return(m_selected_button_text);  }
   int               SelectedButtonIndex(void)              const { return(m_selected_button_index); }
   //--- Set the text by the specified index
   void              Text(const uint index,const string text);
   //--- Setting labels for the button in the active and blocked states
   void              IconFileOn(const uint index,const string file_path);
   void              IconFileOff(const uint index,const string file_path);
   //--- Toggles the button state by the specified index
   void              SelectIconButton(const int index);
   //--- Adds a button with specified properties before creation
   void              AddButton(const int x_gap,const int y_gap,const string text,
                               const int width,const string icon_file_on,const string icon_file_off);
   //--- Changing the color
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
   //---
private:
   //--- Handling of pressing the button
   bool              OnClickButton(const string pressed_object);
   //--- Checking the pressed left mouse button over the group buttons
   void              CheckPressedOverButton(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIconButtonsGroup::CIconButtonsGroup(void) : m_icon_buttons_state(true),
                                             m_buttons_y_size(22),
                                             m_selected_button_text(""),
                                             m_selected_button_index(0),
                                             m_icon_x_gap(4),
                                             m_icon_y_gap(3),
                                             m_label_x_gap(25),
                                             m_label_y_gap(4),
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
   m_zorder         =0;
   m_buttons_zorder =1;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIconButtonsGroup::~CIconButtonsGroup(void)
  {
  }
//+------------------------------------------------------------------+
//| Chart event handler                                              |
//+------------------------------------------------------------------+
void CIconButtonsGroup::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Handling of the cursor movement event
   if(id==CHARTEVENT_MOUSE_MOVE)
     {
      //--- Leave, if the control is hidden
      if(!CElementBase::IsVisible())
         return;
      //--- Leave, if numbers of subwindows do not match
      if(CElementBase::m_subwin!=CElementBase::m_mouse.SubWindowNumber())
         return;
      //--- Leave, if the buttons are blocked
      if(!m_icon_buttons_state)
         return;
      //--- Define the focus
      int icon_buttons_total=IconButtonsTotal();
      for(int i=0; i<icon_buttons_total; i++)
         m_buttons[i].MouseFocus(m_mouse.X()>m_buttons[i].X() && m_mouse.X()<m_buttons[i].X2() && m_mouse.Y()>m_buttons[i].Y() && m_mouse.Y()<m_buttons[i].Y2());
      //--- Leave, if the form is blocked
      if(m_wnd.IsLocked())
         return;
      //--- Leave, if the mouse button is not pressed
      if(!m_mouse.LeftButtonState())
         return;
      //--- Checking the pressed left mouse button over the group buttons
      CheckPressedOverButton();
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Toggle the button state
      if(OnClickButton(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CIconButtonsGroup::OnEventTimer(void)
  {
//--- Change the color, if the form is not blocked
   if(!m_wnd.IsLocked())
      ChangeObjectsColor();
  }
//+------------------------------------------------------------------+
//| Creates a group of the icon button objects                       |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateIconButtonsGroup(const long chart_id,const int subwin,const int x_gap,const int y_gap)
  {
//--- Exit if there is no pointer to the form
   if(!CElement::CheckWindowPointer())
      return(false);
//--- Initializing variables
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =CElement::CalculateX(x_gap);
   m_y        =CElement::CalculateY(y_gap);
//--- Set up a button
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      CreateButton(i);
      CreateIcon(i);
      CreateLabel(i);
      //---
      m_buttons[i].MouseFocus(false);
     }
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create button area                                               |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateButton(const int index)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_icon_button_"+(string)index+"__"+(string)CElementBase::Id();
//--- Calculating coordinates
   int x=m_x+m_buttons_x_gap[index];
   int y=m_y+m_buttons_y_gap[index];
//--- Set up a button
   if(!m_buttons[index].Create(m_chart_id,name,m_subwin,x,y,m_buttons_width[index],m_buttons_y_size))
      return(false);
//--- Set properties
   m_buttons[index].Font(CElementBase::Font());
   m_buttons[index].FontSize(CElementBase::FontSize());
   m_buttons[index].Color(m_back_color);
   m_buttons[index].Description("");
   m_buttons[index].BackColor(m_back_color);
   m_buttons[index].BorderColor(m_border_color);
   m_buttons[index].Corner(m_corner);
   m_buttons[index].Anchor(m_anchor);
   m_buttons[index].Selectable(false);
   m_buttons[index].Z_Order(m_buttons_zorder);
   m_buttons[index].Tooltip("\n");
//--- Store the size
   m_buttons[index].XSize(m_buttons_width[index]);
   m_buttons[index].YSize(m_buttons_y_size);
//--- Margins from the edge
   m_buttons[index].XGap(CElement::CalculateXGap(x));
   m_buttons[index].YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(m_back_color,m_back_color_hover,m_icon_buttons_total[index].m_back_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_buttons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates icon                                                     |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateIcon(const int index)
  {
//--- Leave, if the icon for the button is not required
   if(m_icon_file_on[index]=="" || m_icon_file_off[index]=="")
      return(true);
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_icon_button_bmp_"+(string)index+"__"+(string)CElementBase::Id();
//--- Calculating coordinates
   int x=m_x+m_buttons_x_gap[index]+m_icon_x_gap;
   int y=m_y+m_buttons_y_gap[index]+m_icon_y_gap;
//--- Set the icon
   if(!m_icons[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Setting up properties
   m_icons[index].BmpFileOn("::"+m_icon_file_on[index]);
   m_icons[index].BmpFileOff("::"+m_icon_file_off[index]);
   m_icons[index].State(true);
   m_icons[index].Corner(m_corner);
   m_icons[index].GetInteger(OBJPROP_ANCHOR,m_anchor);
   m_icons[index].Selectable(false);
   m_icons[index].Z_Order(m_zorder);
   m_icons[index].Tooltip("\n");
//--- Margins from the edge
   m_icons[index].XGap(CElement::CalculateXGap(x));
   m_icons[index].YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_icons[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the text label                                           |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::CreateLabel(const int index)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_icon_button_lable_"+(string)index+"__"+(string)CElementBase::Id();
//--- Coordinates
   int x=m_x+m_buttons_x_gap[index]+m_label_x_gap;
   int y=m_y+m_buttons_y_gap[index]+m_label_y_gap;
//--- Set the text label
   if(!m_labels[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_labels[index].Description(m_buttons_text[index]);
   m_labels[index].Font(CElementBase::Font());
   m_labels[index].FontSize(CElementBase::FontSize());
   m_labels[index].Color(m_label_color);
   m_labels[index].Corner(m_corner);
   m_labels[index].Anchor(m_anchor);
   m_labels[index].Selectable(false);
   m_labels[index].Z_Order(m_zorder);
   m_labels[index].Tooltip("\n");
//--- Margins from the edge
   m_labels[index].XGap(CElement::CalculateXGap(x));
   m_labels[index].YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[index].m_label_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_labels[index]);
   return(true);
  }
//+------------------------------------------------------------------+
//| Adds a button                                                    |
//+------------------------------------------------------------------+
void CIconButtonsGroup::AddButton(const int x_gap,const int y_gap,const string text,
                                  const int width,const string icon_file_on,const string icon_file_off)
  {
//--- Increase the array size by one element
   int array_size=::ArraySize(m_buttons_text);
   int new_size=array_size+1;
   ::ArrayResize(m_buttons,new_size);
   ::ArrayResize(m_icons,new_size);
   ::ArrayResize(m_labels,new_size);
   ::ArrayResize(m_buttons_x_gap,new_size);
   ::ArrayResize(m_buttons_y_gap,new_size);
   ::ArrayResize(m_buttons_state,new_size);
   ::ArrayResize(m_buttons_text,new_size);
   ::ArrayResize(m_buttons_width,new_size);
   ::ArrayResize(m_icon_file_on,new_size);
   ::ArrayResize(m_icon_file_off,new_size);
   ::ArrayResize(m_icon_buttons_total,new_size);
//--- Store the values of passed parameters
   m_buttons_x_gap[array_size] =x_gap;
   m_buttons_y_gap[array_size] =y_gap;
   m_buttons_text[array_size]  =text;
   m_buttons_width[array_size] =width;
   m_icon_file_on[array_size]  =icon_file_on;
   m_icon_file_off[array_size] =icon_file_off;
   m_buttons_state[array_size] =false;
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CIconButtonsGroup::ChangeObjectsColor(void)
  {
//--- Leave, if the element is blocked
   if(!m_icon_buttons_state)
      return;
//---
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      color label_color=(m_buttons_state[i]) ? m_label_color : m_label_color_off;
      CElementBase::ChangeObjectColor(m_labels[i].Name(),m_buttons[i].MouseFocus(),
                                  OBJPROP_COLOR,label_color,m_label_color_pressed,m_icon_buttons_total[i].m_label_color_array);
      CElementBase::ChangeObjectColor(m_buttons[i].Name(),m_buttons[i].MouseFocus(),
                                  OBJPROP_BGCOLOR,m_back_color,m_back_color_hover,m_icon_buttons_total[i].m_back_color_array);
     }
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Moving(const int x,const int y,const bool moving_mode=false)
  {
//--- Leave, if the control is hidden
   if(!CElementBase::IsVisible())
      return;
//--- If the management is delegated to the window, identify its location
   if(!moving_mode)
      if(m_wnd.ClampingAreaMouse()!=PRESSED_INSIDE_HEADER)
         return;
//--- Get the number of buttons
   int icon_buttons_total=IconButtonsTotal();
//--- If the anchored to the right
   if(m_anchor_right_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::X(m_wnd.X2()-XGap());
      //--- Storing coordinates in the fields of the objects
      for(int i=0; i<icon_buttons_total; i++)
        {
         m_buttons[i].X(m_wnd.X2()-m_buttons[i].XGap());
         m_icons[i].X(m_wnd.X2()-m_icons[i].XGap());
         m_labels[i].X(m_wnd.X2()-m_labels[i].XGap());
        }
     }
   else
     {
      //--- Storing coordinates in the element fields
      CElementBase::X(x+XGap());
      //--- Storing coordinates in the fields of the objects
      for(int i=0; i<icon_buttons_total; i++)
        {
         m_buttons[i].X(x+m_buttons[i].XGap());
         m_icons[i].X(x+m_icons[i].XGap());
         m_labels[i].X(x+m_labels[i].XGap());
        }
     }
//--- If the anchored to the bottom
   if(m_anchor_bottom_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(m_wnd.Y2()-YGap());
      //--- Storing coordinates in the fields of the objects
      for(int i=0; i<icon_buttons_total; i++)
        {
         m_buttons[i].Y(m_wnd.Y2()-m_buttons[i].YGap());
         m_icons[i].Y(m_wnd.Y2()-m_icons[i].YGap());
         m_labels[i].Y(m_wnd.Y2()-m_labels[i].YGap());
        }
     }
   else
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(y+YGap());
      //--- Storing coordinates in the fields of the objects
      for(int i=0; i<icon_buttons_total; i++)
        {
         m_buttons[i].Y(y+m_buttons[i].YGap());
         m_icons[i].Y(y+m_icons[i].YGap());
         m_labels[i].Y(y+m_labels[i].YGap());
        }
     }
//--- Updating coordinates of graphical objects
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].X_Distance(m_buttons[i].X());
      m_buttons[i].Y_Distance(m_buttons[i].Y());
      m_icons[i].X_Distance(m_icons[i].X());
      m_icons[i].Y_Distance(m_icons[i].Y());
      m_labels[i].X_Distance(m_labels[i].X());
      m_labels[i].Y_Distance(m_labels[i].Y());
     }
  }
//+------------------------------------------------------------------+
//| Shows the button                                                 |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Show(void)
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
void CIconButtonsGroup::Hide(void)
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
void CIconButtonsGroup::Reset(void)
  {
//--- Leave, if this is a drop-down control 
   if(CElementBase::IsDropdown())
      return;
//--- Hide and show
   Hide();
   Show();
  }
//+------------------------------------------------------------------+
//| Remove                                                         |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Delete(void)
  {
//--- Removing objects
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Delete();
      m_icons[i].Delete();
      m_labels[i].Delete();
     }
//--- Emptying the control arrays
   ::ArrayFree(m_buttons_x_gap);
   ::ArrayFree(m_buttons_y_gap);
   ::ArrayFree(m_buttons_width);
   ::ArrayFree(m_buttons_state);
   ::ArrayFree(m_buttons_text);
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CIconButtonsGroup::SetZorders(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Z_Order(m_buttons_zorder);
      m_icons[i].Z_Order(m_zorder);
      m_labels[i].Z_Order(m_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CIconButtonsGroup::ResetZorders(void)
  {
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_buttons[i].Z_Order(-1);
      m_icons[i].Z_Order(-1);
      m_labels[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| Changing the state of buttons                                    |
//+------------------------------------------------------------------+
void CIconButtonsGroup::IconButtonsState(const bool state)
  {
   m_icon_buttons_state=state;
//---
   int icon_buttons_total=IconButtonsTotal();
   for(int i=0; i<icon_buttons_total; i++)
     {
      m_icons[i].State(state);
      m_buttons[i].State(false);
      m_labels[i].Color((state)? m_label_color : m_label_color_off);
      m_buttons[i].BackColor((state)? m_back_color : m_back_color_off);
     }
//---
   if(state)
      SelectIconButton(m_selected_button_index);
  }
//+------------------------------------------------------------------+
//| Sets the button text                                             |
//+------------------------------------------------------------------+
void CIconButtonsGroup::Text(const uint index,const string text)
  {
//--- Get the number of buttons
   uint icon_buttons_total=IconButtonsTotal();
//--- Leave, if there is no button in a group
   if(icon_buttons_total<1)
      return;
//--- Adjust the index value if the array range is exceeded
   uint correct_index=(index>=icon_buttons_total)? icon_buttons_total-1 : index;
//--- Store and set the text
   m_buttons_text[correct_index]=text;
   m_labels[correct_index].Description(text);
  }
//+------------------------------------------------------------------+
//| Set icon for the "ON" state                                      |
//+------------------------------------------------------------------+
void CIconButtonsGroup::IconFileOn(const uint index,const string file_path)
  {
//--- Get the number of buttons
   uint icon_buttons_total=IconButtonsTotal();
//--- Leave, if there is no button in a group
   if(icon_buttons_total<1)
      return;
//--- Adjust the index value if the array range is exceeded
   uint correct_index=(index>=icon_buttons_total)? icon_buttons_total-1 : index;
//--- Store and set the icon
   m_icon_file_on[correct_index]=file_path;
   m_icons[correct_index].BmpFileOn("::"+file_path);
  }
//+------------------------------------------------------------------+
//| Set icon for the "OFF" state                                     |
//+------------------------------------------------------------------+
void CIconButtonsGroup::IconFileOff(const uint index,const string file_path)
  {
//--- Get the number of buttons
   uint icon_buttons_total=IconButtonsTotal();
//--- Leave, if there is no button in a group
   if(icon_buttons_total<1)
      return;
//--- Adjust the index value if the array range is exceeded
   uint correct_index=(index>=icon_buttons_total)? icon_buttons_total-1 : index;
//--- Store and set the icon
   m_icon_file_off[correct_index]=file_path;
   m_icons[correct_index].BmpFileOff("::"+file_path);
  }
//+------------------------------------------------------------------+
//| Indicates the button to be selected                              |
//+------------------------------------------------------------------+
void CIconButtonsGroup::SelectIconButton(const int index)
  {
//--- Get the number of buttons
   int icon_buttons_total=IconButtonsTotal();
//--- If there is no radio button in the group, report
   if(icon_buttons_total<1)
     {
      ::Print(__FUNCTION__," > This method is to be called, "
              "if a group contains at least one button! Use the CIconButtonsGroup::AddButton() method");
     }
//--- Adjust the index value if the array range is exceeded
   int correct_index=(index>=icon_buttons_total)? icon_buttons_total-1 :(index<0)? 0 : index;
//--- Toggle the button state
   for(int i=0; i<icon_buttons_total; i++)
     {
      if(i==correct_index)
        {
         m_buttons_state[i]=true;
         m_icons[i].State(true);
         m_buttons[i].State(true);
         m_labels[i].Color(m_label_color_hover);
         m_buttons[i].BackColor(m_back_color_pressed);
         CElementBase::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[i].m_label_color_array);
        }
      else
        {
         m_buttons_state[i]=false;
         m_icons[i].State(false);
         m_buttons[i].State(false);
         m_labels[i].Color(m_label_color);
         m_buttons[i].BackColor(m_back_color);
         CElementBase::InitColorArray(m_label_color,m_label_color_hover,m_icon_buttons_total[i].m_label_color_array);
        }
     }
//--- Store its text and index
   m_selected_button_index =correct_index;
   m_selected_button_text  =m_buttons_text[correct_index];
  }
//+------------------------------------------------------------------+
//| Pressing of a radio button                                       |
//+------------------------------------------------------------------+
bool CIconButtonsGroup::OnClickButton(const string pressed_object)
  {
//--- Leave, if the clicking was not on the menu item
   if(::StringFind(pressed_object,CElementBase::ProgramName()+"_icon_button_",0)<0)
      return(false);
//--- Get the identifier and index from the object name
   int id=CElementBase::IdFromObjectName(pressed_object);
//--- Leave, if identifiers do not match
   if(id!=CElementBase::Id())
      return(false);
//--- For checking the index
   int check_index=WRONG_VALUE;
//--- Get the number of buttons
   int icon_buttons_total=IconButtonsTotal();
//--- Leave, if the buttons are blocked
   if(!m_icon_buttons_state)
     {
      for(int i=0; i<icon_buttons_total; i++)
         m_buttons[i].State(false);
      //---
      return(false);
     }
//--- If the pressing took place, store the index
   for(int i=0; i<icon_buttons_total; i++)
     {
      if(m_buttons[i].Name()==pressed_object)
        {
         check_index=i;
         break;
        }
     }
//--- Leave, if there was no pressing of a button in this group or
//    if it is an already selected button
   if(check_index==WRONG_VALUE || check_index==m_selected_button_index)
     {
      m_buttons[check_index].State(true);
      return(false);
     }
//--- Toggle the button state
   SelectIconButton(check_index);
//--- Send a signal about it
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElementBase::Id(),m_selected_button_index,m_selected_button_text);
   return(true);
  }
//+------------------------------------------------------------------+
//| Checking the pressed left mouse button over the group buttons    |
//+------------------------------------------------------------------+
void CIconButtonsGroup::CheckPressedOverButton(void)
  {
   int buttons_total=IconButtonsTotal();
//--- Set the color depending on the location of the left mouse button press
   for(int i=0; i<buttons_total; i++)
     {
      //--- If there is a focus, then the color of the pressed button
      if(m_buttons[i].MouseFocus())
         m_buttons[i].BackColor(m_back_color_pressed);
      //--- If there is no focus, then...
      else
        {
         //--- ...if a group button is not pressed, assign the background color
         if(!m_buttons_state[i])
            m_buttons[i].BackColor(m_back_color);
        }
     }
  }
//+------------------------------------------------------------------+
