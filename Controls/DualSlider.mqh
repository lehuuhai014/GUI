//+------------------------------------------------------------------+
//|                                                   DualSlider.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
#include "SeparateLine.mqh"
//+------------------------------------------------------------------+
//| Class for creating a dual slider with edits                      |
//+------------------------------------------------------------------+
class CDualSlider : public CElement
  {
private:
   //--- Objects for creating the element
   CRectLabel        m_area;
   CLabel            m_label;
   CEdit             m_left_edit;
   CEdit             m_right_edit;
   CSeparateLine     m_slot;
   CRectLabel        m_indicator;
   CRectLabel        m_left_thumb;
   CRectLabel        m_right_thumb;
   //--- Color of the element background
   color             m_area_color;
   //--- Text of the checkbox
   string            m_label_text;
   //--- Colors of the text label in different states
   color             m_label_color;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- The current value in the edits
   double            m_left_edit_value;
   double            m_right_edit_value;
   //--- Size of the entry field
   int               m_edit_x_size;
   int               m_edit_y_size;
   //--- Colors of the entry field in different states
   color             m_edit_color;
   color             m_edit_color_locked;
   //--- Colors of the text of the entry field in different states
   color             m_edit_text_color;
   color             m_edit_text_color_locked;
   //--- Colors of the edit frame in different states
   color             m_edit_border_color;
   color             m_edit_border_color_hover;
   color             m_edit_border_color_locked;
   color             m_edit_border_color_array[];
   //--- Size of the slit
   int               m_slot_y_size;
   //--- Colors of the slit
   color             m_slot_line_dark_color;
   color             m_slot_line_light_color;
   //--- Colors of the indicator in different states
   color             m_slot_indicator_color;
   color             m_slot_indicator_color_locked;
   //--- Size of the slider runner
   int               m_thumb_x_size;
   int               m_thumb_y_size;
   //--- Colors of the slider runner
   color             m_thumb_color;
   color             m_thumb_color_hover;
   color             m_thumb_color_locked;
   color             m_thumb_color_pressed;
   //--- Priorities of the left mouse button click
   int               m_zorder;
   int               m_area_zorder;
   int               m_edit_zorder;
   //--- (1) Minimum and (2) maximum value, (3) step for changing the value
   double            m_min_value;
   double            m_max_value;
   double            m_step_value;
   //--- Number of decimal places
   int               m_digits;
   //--- Mode of text alignment
   ENUM_ALIGN_MODE   m_align_mode;
   //--- Checkbox state (available/blocked)
   bool              m_slider_state;
   //--- Current position of the slider runners
   double            m_left_current_pos;
   double            m_left_current_pos_x;
   double            m_right_current_pos;
   double            m_right_current_pos_x;
   //--- Number of pixels in the working area
   int               m_pixels_total;
   //--- Number of steps in the working area
   int               m_value_steps_total;
   //--- Step in relation to the width of the working area
   double            m_position_step;
   //--- State of the mouse button (pressed/released)
   ENUM_MOUSE_STATE  m_clamping_mouse_left_thumb;
   ENUM_MOUSE_STATE  m_clamping_mouse_right_thumb;
   //--- To identify the mode of the slider runner movement
   bool              m_slider_thumb_state;
   //--- Variables connected with the slider movement
   int               m_slider_size_fixing;
   int               m_slider_point_fixing;
   //---
public:
                     CDualSlider(void);
                    ~CDualSlider(void);
   //--- Methods for creating the control
   bool              CreateSlider(const long chart_id,const int subwin,const string text,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabel(void);
   bool              CreateLeftEdit(void);
   bool              CreateRightEdit(void);
   bool              CreateSlot(void);
   bool              CreateIndicator(void);
   bool              CreateLeftThumb(void);
   bool              CreateRightThumb(void);
   //---
public:
   //--- (1) Background color, (2) get/set the state of the control
   void              AreaColor(const color clr)                     { m_area_color=clr;                   }
   bool              SliderState(void) const                        { return(m_slider_state);             }
   void              SliderState(const bool state);
   //--- Colors of the text label
   void              LabelColor(const color clr)                    { m_label_color=clr;                  }
   void              LabelColorHover(const color clr)               { m_label_color_hover=clr;            }
   void              LabelColorLocked(const color clr)              { m_label_color_locked=clr;           }
   //--- (1) Gets/sets description of the control
   string            LabelText(void)                          const { return(m_label.Description());      }
   void              LabelText(const string text)                   { m_label.Description(text);          }
   //--- Size of (1) the edit and (2) the slot
   void              EditXSize(const int x_size)                    { m_edit_x_size=x_size;               }
   void              EditYSize(const int y_size)                    { m_edit_y_size=y_size;               }
   void              SlotYSize(const int y_size)                    { m_slot_y_size=y_size;               }
   //--- Colors of the entry field in different states
   void              EditColor(const color clr)                     { m_edit_color=clr;                   }
   void              EditColorLocked(const color clr)               { m_edit_color_locked=clr;            }
   //--- Colors of the text of the entry field in different states
   void              EditTextColor(const color clr)                 { m_edit_text_color=clr;              }
   void              EditTextColorLocked(const color clr)           { m_edit_text_color_locked=clr;       }
   //--- Colors of the edit frame in different states
   void              EditBorderColor(const color clr)               { m_edit_border_color=clr;            }
   void              EditBorderColorHover(const color clr)          { m_edit_border_color_hover=clr;      }
   void              EditBorderColorLocked(const color clr)         { m_edit_border_color_locked=clr;     }
   //--- (1) Dark and (2) light color of the separation line (slit)
   void              SlotLineDarkColor(const color clr)             { m_slot_line_dark_color=clr;         }
   void              SlotLineLightColor(const color clr)            { m_slot_line_light_color=clr;        }
   //--- Colors of the slider indicator in different states
   void              SlotIndicatorColor(const color clr)            { m_slot_indicator_color=clr;         }
   void              SlotIndicatorColorLocked(const color clr)      { m_slot_indicator_color_locked=clr;  }
   //--- Size of the slider runner
   void              ThumbXSize(const int x_size)                   { m_thumb_x_size=x_size;              }
   void              ThumbYSize(const int y_size)                   { m_thumb_y_size=y_size;              }
   //--- Colors of the slider runner
   void              ThumbColor(const color clr)                    { m_thumb_color=clr;                  }
   void              ThumbColorHover(const color clr)               { m_thumb_color_hover=clr;            }
   void              ThumbColorLocked(const color clr)              { m_thumb_color_locked=clr;           }
   void              ThumbColorPressed(const color clr)             { m_thumb_color_pressed=clr;          }
   //--- Minimum value
   double            MinValue(void)                           const { return(m_min_value);                }
   void              MinValue(const double value)                   { m_min_value=value;                  }
   //--- Maximum value
   double            MaxValue(void)                           const { return(m_max_value);                }
   void              MaxValue(const double value)                   { m_max_value=value;                  }
   //--- Step of changing the value
   double            StepValue(void)                          const { return(m_step_value);               }
   void              StepValue(const double value)                  { m_step_value=(value<=0)? 1 : value; }
   //--- (1) Number of decimal places, (2) mode of text alignment
   void              SetDigits(const int digits)                    { m_digits=::fabs(digits);            }
   void              AlignMode(ENUM_ALIGN_MODE mode)                { m_align_mode=mode;                  }
   //--- Return and set the value in entry fields (left and right)
   double            GetLeftValue(void)                       const { return(m_left_edit_value);          }
   double            GetRightValue(void)                      const { return(m_right_edit_value);         }
   bool              SetLeftValue(double value);
   bool              SetRightValue(double value);
   //--- Changing values in entry fields (left and right)
   void              ChangeLeftValue(const double value);
   void              ChangeRightValue(const double value);
   //--- Changing the object color when the cursor is hovering over it
   void              ChangeObjectsColor(void);
   //--- Change the color of the slider runner
   void              ChangeThumbColor(void);
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
   virtual void      ResetColors(void) {}
   //---
private:
   //--- Handling the value entering in the edit
   bool              OnEndEdit(const string object_name);
   //--- Process of moving slider runners (left and right)
   void              OnDragLeftThumb(const int x);
   void              OnDragRightThumb(const int x);
   //--- Updating position of slider runners (left and right)
   void              UpdateLeftThumb(const int new_x_point);
   void              UpdateRightThumb(const int new_x_point);
   //--- Checks the state of the left mouse button over the slider runner
   void              CheckMouseOnLeftThumb(void);
   void              CheckMouseOnRightThumb(void);
   //--- Zeroing variables connected with the slider runner movement
   void              ZeroThumbVariables(void);
   //--- Calculation of values (steps and coefficients)
   bool              CalculateCoefficients(void);
   //--- Calculating the X coordinate of sliders (left and right)
   void              CalculateLeftThumbX(void);
   void              CalculateRightThumbX(void);
   //--- Changes position of the left slider runner in relation to the value (left and right)
   void              CalculateLeftThumbPos(void);
   void              CalculateRightThumbPos(void);
   //--- Updating the slider indicator
   void              UpdateIndicator(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CDualSlider::CDualSlider(void) : m_digits(2),
                                 m_left_edit_value(WRONG_VALUE),
                                 m_right_edit_value(WRONG_VALUE),
                                 m_align_mode(ALIGN_LEFT),
                                 m_slider_state(true),
                                 m_slider_size_fixing(0),
                                 m_slider_point_fixing(0),
                                 m_min_value(0),
                                 m_max_value(10),
                                 m_step_value(1),
                                 m_left_current_pos(WRONG_VALUE),
                                 m_right_current_pos(WRONG_VALUE),
                                 m_area_color(clrNONE),
                                 m_label_color(clrBlack),
                                 m_label_color_hover(C'85,170,255'),
                                 m_label_color_locked(clrSilver),
                                 m_edit_x_size(30),
                                 m_edit_y_size(18),
                                 m_edit_color(clrWhite),
                                 m_edit_color_locked(clrWhiteSmoke),
                                 m_edit_text_color(clrBlack),
                                 m_edit_text_color_locked(clrSilver),
                                 m_edit_border_color(clrSilver),
                                 m_edit_border_color_hover(C'85,170,255'),
                                 m_edit_border_color_locked(clrSilver),
                                 m_slot_y_size(4),
                                 m_slot_line_dark_color(clrSilver),
                                 m_slot_line_light_color(clrWhite),
                                 m_slot_indicator_color(C'85,170,255'),
                                 m_slot_indicator_color_locked(clrLightGray),
                                 m_thumb_x_size(6),
                                 m_thumb_y_size(14),
                                 m_thumb_color(C'170,170,170'),
                                 m_thumb_color_hover(C'200,200,200'),
                                 m_thumb_color_locked(clrLightGray),
                                 m_thumb_color_pressed(clrSilver)
  {
//--- Store the name of the element class in the base class
   CElementBase::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_zorder      =0;
   m_area_zorder =1;
   m_edit_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CDualSlider::~CDualSlider(void)
  {
  }
//+------------------------------------------------------------------+
//| Chart event handler                                              |
//+------------------------------------------------------------------+
void CDualSlider::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_left_thumb.MouseFocus(m_mouse.X()>m_left_thumb.X() && m_mouse.X()<m_left_thumb.X2() && 
                              m_mouse.Y()>m_left_thumb.Y() && m_mouse.Y()<m_left_thumb.Y2());
      m_right_thumb.MouseFocus(m_mouse.X()>m_right_thumb.X() && m_mouse.X()<m_right_thumb.X2() && 
                               m_mouse.Y()>m_right_thumb.Y() && m_mouse.Y()<m_right_thumb.Y2());
      //--- Leave, if the element is blocked
      if(!m_slider_state)
         return;
      //--- Verify and store the state of the mouse button
      CheckMouseOnLeftThumb();
      CheckMouseOnRightThumb();
      //--- Change the color of the slider runner
      ChangeThumbColor();
      //--- If the management is passed to the slider line (left slider runner)
      if(m_clamping_mouse_left_thumb==PRESSED_INSIDE)
        {
         //--- Moving the slider runner
         OnDragLeftThumb(m_mouse.X());
         //--- Calculation of the slider runner position in the value range
         CalculateLeftThumbPos();
         //--- Setting a new value in the edit
         ChangeLeftValue(m_left_current_pos);
         //--- Update the slider indicator
         UpdateIndicator();
         return;
        }
      //--- If the management is passed to the scrollbar (right slider runner)
      if(m_clamping_mouse_right_thumb==PRESSED_INSIDE)
        {
         //--- Moving the slider runner
         OnDragRightThumb(m_mouse.X());
         //--- Calculation of the slider runner position in the value range
         CalculateRightThumbPos();
         //--- Setting a new value in the edit
         ChangeRightValue(m_right_current_pos);
         //--- Update the slider indicator
         UpdateIndicator();
         return;
        }
     }
//--- Handling the value change in edit event
   if(id==CHARTEVENT_OBJECT_ENDEDIT)
     {
      //--- Handling of the value entry
      if(OnEndEdit(sparam))
         return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CDualSlider::OnEventTimer(void)
  {
//--- If the element is a drop-down
   if(CElementBase::IsDropdown())
      ChangeObjectsColor();
   else
     {
      //--- If the form and the element are not blocked
      if(!m_wnd.IsLocked())
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Creates a group of editable edit control                         |
//+------------------------------------------------------------------+
bool CDualSlider::CreateSlider(const long chart_id,const int subwin,const string text,const int x_gap,const int y_gap)
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
   m_label_text =text;
   m_area_color =(m_area_color!=clrNONE)? m_area_color : m_wnd.WindowBgColor();
//--- Margins from the edge
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
//--- Creating an element
   if(!CreateArea())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateLeftEdit())
      return(false);
   if(!CreateRightEdit())
      return(false);
   if(!CreateSlot())
      return(false);
   if(!CreateIndicator())
      return(false);
   if(!CreateLeftThumb())
      return(false);
   if(!CreateRightThumb())
      return(false);
      
//--- Calculation of the X coordinates of the left slider runner in relation to the current value in the left edit
   CalculateLeftThumbX();
//--- Calculation of the left slider runner position in the value range
   CalculateLeftThumbPos();
//--- Update the slider runner
   UpdateLeftThumb(m_left_thumb.X());
//--- Update the slider indicator
   UpdateIndicator();
   
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create area of editable edit control                             |
//+------------------------------------------------------------------+
bool CDualSlider::CreateArea(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_area_"+(string)CElementBase::Id();
//--- Set the object
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Set properties
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Store coordinates
   m_area.X(CElementBase::X());
   m_area.Y(CElementBase::Y());
//--- Sizes
   m_area.XSize(CElementBase::XSize());
   m_area.YSize(CElementBase::YSize());
//--- Margins from the edge
   m_area.XGap(CElement::CalculateXGap(m_x));
   m_area.YGap(CElement::CalculateYGap(m_y));
//--- Store the object pointer
   CElementBase::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create label of editable edit control                            |
//+------------------------------------------------------------------+
bool CDualSlider::CreateLabel(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_lable_"+(string)CElementBase::Id();
//--- Coordinates
   int x=CElementBase::X();
   int y=m_y+5;
//--- Set the object
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
//m_label.Hidden(true);
   m_label.Tooltip("\n");
//--- Store coordinates
   m_area.X(x);
   m_area.Y(y);
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
//| Create left edit control                                         |
//+------------------------------------------------------------------+
bool CDualSlider::CreateLeftEdit(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_left_edit_"+(string)CElementBase::Id();
//--- Coordinates
   int x=CElementBase::X2()-(m_edit_x_size*2)-5;
   int y=m_y+3;
//--- Set the object
   if(!m_left_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- Set properties
   m_left_edit.Font(CElementBase::Font());
   m_left_edit.FontSize(CElementBase::FontSize());
   m_left_edit.TextAlign(m_align_mode);
   m_left_edit.Description(::DoubleToString(m_left_edit_value,m_digits));
   m_left_edit.Color(m_edit_text_color);
   m_left_edit.BorderColor(m_edit_border_color);
   m_left_edit.BackColor(m_edit_color);
   m_left_edit.Corner(m_corner);
   m_left_edit.Anchor(m_anchor);
   m_left_edit.Selectable(false);
   m_left_edit.Z_Order(m_edit_zorder);
//m_left_edit.Hidden(true);
   m_left_edit.Tooltip("\n");
//--- Store coordinates
   m_left_edit.X(x);
   m_left_edit.Y(y);
//--- Sizes
   m_left_edit.XSize(m_edit_x_size);
   m_left_edit.YSize(m_edit_y_size);
//--- Margins from the edge
   m_left_edit.XGap(CElement::CalculateXGap(x));
   m_left_edit.YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_left_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create right edit control                                        |
//+------------------------------------------------------------------+
bool CDualSlider::CreateRightEdit(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_right_edit_"+(string)CElementBase::Id();
//--- Coordinates
   int x=CElementBase::X2()-m_edit_x_size;
   int y=m_y+3;
//--- Set the object
   if(!m_right_edit.Create(m_chart_id,name,m_subwin,x,y,m_edit_x_size,m_edit_y_size))
      return(false);
//--- Set properties
   m_right_edit.Font(CElementBase::Font());
   m_right_edit.FontSize(CElementBase::FontSize());
   m_right_edit.TextAlign(m_align_mode);
   m_right_edit.Description(::DoubleToString(m_right_edit_value,m_digits));
   m_right_edit.Color(m_edit_text_color);
   m_right_edit.BorderColor(m_edit_border_color);
   m_right_edit.BackColor(m_edit_color);
   m_right_edit.Corner(m_corner);
   m_right_edit.Anchor(m_anchor);
   m_right_edit.Selectable(false);
   m_right_edit.Z_Order(m_edit_zorder);
//m_right_edit.Hidden(true);
   m_right_edit.Tooltip("\n");
//--- Store coordinates
   m_right_edit.X(x);
   m_right_edit.Y(y);
//--- Sizes
   m_right_edit.XSize(m_edit_x_size);
   m_right_edit.YSize(m_edit_y_size);
//--- Margins from the edge
   m_right_edit.XGap(CElement::CalculateXGap(x));
   m_right_edit.YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   InitColorArray(m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_right_edit);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create slot for the scrollbar                                    |
//+------------------------------------------------------------------+
bool CDualSlider::CreateSlot(void)
  {
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X());
   int y=CElement::CalculateYGap(CElementBase::Y()+30);
//--- Store the form pointer
   m_slot.WindowPointer(m_wnd);
//--- Set properties
   m_slot.TypeSepLine(H_SEP_LINE);
   m_slot.DarkColor(m_slot_line_dark_color);
   m_slot.LightColor(m_slot_line_light_color);
   m_slot.AnchorRightWindowSide(m_anchor_right_window_side);
   m_slot.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Creating a separation line
   if(!m_slot.CreateSeparateLine(m_chart_id,m_subwin,0,x,y,CElementBase::XSize(),m_slot_y_size))
      return(false);
//--- Store the object pointer
   CElementBase::AddToArray(m_slot.Object(0));
   return(true);
  }
//+------------------------------------------------------------------+
//| Create scrollbar indicator                                       |
//+------------------------------------------------------------------+
bool CDualSlider::CreateIndicator(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_indicator_"+(string)CElementBase::Id();
//--- Coordinates
   int x=CElementBase::X();
   int y=m_slot.Y()+1;
//--- Size
   int y_size=m_slot_y_size-2;
//--- Set the object
   if(!m_indicator.Create(m_chart_id,name,m_subwin,x,y,m_x_size,y_size))
      return(false);
//--- Set properties
   m_indicator.BackColor(m_slot_indicator_color);
   m_indicator.Color(m_slot_indicator_color);
   m_indicator.BorderType(BORDER_FLAT);
   m_indicator.Corner(m_corner);
   m_indicator.Selectable(false);
   m_indicator.Z_Order(m_zorder);
//m_indicator.Hidden(true);
   m_indicator.Tooltip("\n");
//--- Store coordinates
   m_indicator.X(x);
   m_indicator.Y(y);
//--- Sizes
   m_indicator.XSize(CElementBase::XSize());
   m_indicator.YSize(y_size);
//--- Margins from the edge
   m_indicator.XGap(CElement::CalculateXGap(x));
   m_indicator.YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_indicator);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the left scrollbar                                       |
//+------------------------------------------------------------------+
bool CDualSlider::CreateLeftThumb(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_left_thumb_"+(string)CElementBase::Id();
//--- Coordinates
   int x=CElementBase::X();
   int y=m_slot.Y()-((m_thumb_y_size-m_slot_y_size)/2);
//--- Set the object
   if(!m_left_thumb.Create(m_chart_id,name,m_subwin,x,y,m_thumb_x_size,m_thumb_y_size))
      return(false);
//--- Set properties
   m_left_thumb.BackColor(m_thumb_color);
   m_left_thumb.Color(m_thumb_color);
   m_left_thumb.BorderType(BORDER_FLAT);
   m_left_thumb.Corner(m_corner);
   m_left_thumb.Selectable(false);
   m_left_thumb.Z_Order(m_zorder);
   m_left_thumb.Tooltip("\n");
//--- Store sizes (in object)
   m_left_thumb.XSize(m_thumb_x_size);
   m_left_thumb.YSize(m_thumb_y_size);
//--- Store coordinates
   m_left_thumb.X(x);
   m_left_thumb.Y(y);
//--- Margins from the edge
   m_left_thumb.XGap(CElement::CalculateXGap(x));
   m_left_thumb.YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_left_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the right scrollbar                                      |
//+------------------------------------------------------------------+
bool CDualSlider::CreateRightThumb(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_slider_right_thumb_"+(string)CElementBase::Id();
//--- Coordinates
   int x=CElementBase::X();
   int y=m_slot.Y()-((m_thumb_y_size-m_slot_y_size)/2);
//--- Set the object
   if(!m_right_thumb.Create(m_chart_id,name,m_subwin,x,y,m_thumb_x_size,m_thumb_y_size))
      return(false);
//--- Set properties
   m_right_thumb.BackColor(m_thumb_color);
   m_right_thumb.Color(m_thumb_color);
   m_right_thumb.BorderType(BORDER_FLAT);
   m_right_thumb.Corner(m_corner);
   m_right_thumb.Selectable(false);
   m_right_thumb.Z_Order(m_zorder);
   m_right_thumb.Tooltip("\n");
//--- Store coordinates
   m_right_thumb.X(x);
   m_right_thumb.Y(y);
//--- Store the size
   m_right_thumb.XSize(m_thumb_x_size);
   m_right_thumb.YSize(m_thumb_y_size);
//--- Margins from the edge
   m_right_thumb.XGap(CElement::CalculateXGap(x));
   m_right_thumb.YGap(CElement::CalculateYGap(y));
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
//--- Calculation of the values of auxiliary variables
   CalculateCoefficients();
//--- Calculation of the X coordinates of the slider runner in relation to the current value in the entry field
   CalculateRightThumbX();
//--- Calculation of the slider runner position in the value range
   CalculateRightThumbPos();
//--- Update the slider runner
   UpdateRightThumb(m_right_thumb.X());
//--- Update the slider indicator
   UpdateIndicator();
//--- Store the object pointer
   CElementBase::AddToArray(m_right_thumb);
   return(true);
  }
//+------------------------------------------------------------------+
//| Set the current value in the left edit control                   |
//+------------------------------------------------------------------+
bool CDualSlider::SetLeftValue(double value)
  {
//--- Adjust considering the step
   double corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- Check for the minimum/maximum
   if(corrected_value<=m_min_value)
      corrected_value=m_min_value;
   if(corrected_value>=m_max_value)
      corrected_value=m_max_value;
//--- If the value has been changed
   if(m_left_edit_value!=corrected_value)
     {
      m_left_edit_value=corrected_value;
      return(true);
     }
//--- Value unchanged
   return(false);
  }
//+------------------------------------------------------------------+
//| Changing the value in the left edit                              |
//+------------------------------------------------------------------+
void CDualSlider::ChangeLeftValue(const double value)
  {
//--- Check, adjust and store the new value
   SetLeftValue(value);
//--- Set the new value in the edit
   m_left_edit.Description(::DoubleToString(GetLeftValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| Set the current value in the right edit control                  |
//+------------------------------------------------------------------+
bool CDualSlider::SetRightValue(double value)
  {
//--- Adjust considering the step
   double corrected_value=::MathRound(value/m_step_value)*m_step_value;
//--- Check for the minimum/maximum
   if(corrected_value<=m_min_value)
      corrected_value=m_min_value;
   if(corrected_value>=m_max_value)
      corrected_value=m_max_value;
//--- If the value has been changed
   if(m_right_edit_value!=corrected_value)
     {
      m_right_edit_value=corrected_value;
      return(true);
     }
//--- Value unchanged
   return(false);
  }
//+------------------------------------------------------------------+
//| Changing the value in the right edit                             |
//+------------------------------------------------------------------+
void CDualSlider::ChangeRightValue(const double value)
  {
//--- Check, adjust and store the new value
   SetRightValue(value);
//--- Set the new value in the edit
   m_right_edit.Description(::DoubleToString(GetRightValue(),m_digits));
  }
//+------------------------------------------------------------------+
//| Change the state of the control                                  |
//+------------------------------------------------------------------+
void CDualSlider::SliderState(const bool state)
  {
//--- Control state
   m_slider_state=state;
//--- Color of the text label
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- Color of the edit
   m_left_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_left_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_left_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
   m_right_edit.Color((state)? m_edit_text_color : m_edit_text_color_locked);
   m_right_edit.BackColor((state)? m_edit_color : m_edit_color_locked);
   m_right_edit.BorderColor((state)? m_edit_border_color : m_edit_border_color_locked);
//--- Color of the indicator
   m_indicator.BackColor((state)? m_slot_indicator_color : m_slot_indicator_color_locked);
   m_indicator.Color((state)? m_slot_indicator_color : m_slot_indicator_color_locked);
//--- Color of the slider runner
   m_left_thumb.BackColor((state)? m_thumb_color : m_thumb_color_locked);
   m_left_thumb.Color((state)? m_thumb_color : m_thumb_color_locked);
   m_right_thumb.BackColor((state)? m_thumb_color : m_thumb_color_locked);
   m_right_thumb.Color((state)? m_thumb_color : m_thumb_color_locked);
//--- Setting in relation of the current state
   if(!m_slider_state)
     {
      //--- Edit in the read only mode
      m_left_edit.ReadOnly(true);
      m_right_edit.ReadOnly(true);
     }
   else
     {
      //--- The edit control in the edit mode
      m_left_edit.ReadOnly(false);
      m_right_edit.ReadOnly(false);
     }
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CDualSlider::ChangeObjectsColor(void)
  {
//--- Leave, if the control is blocked or is in the mode of the slider runner movement
   if(!m_slider_state || m_slider_thumb_state)
      return;
//---
   CElementBase::ChangeObjectColor(m_label.Name(),CElementBase::MouseFocus(),OBJPROP_COLOR,m_label_color,m_label_color_hover,m_label_color_array);
   CElementBase::ChangeObjectColor(m_left_edit.Name(),CElementBase::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
   CElementBase::ChangeObjectColor(m_right_edit.Name(),CElementBase::MouseFocus(),OBJPROP_BORDER_COLOR,m_edit_border_color,m_edit_border_color_hover,m_edit_border_color_array);
  }
//+------------------------------------------------------------------+
//| Change the color of the scrollbar                                |
//+------------------------------------------------------------------+
void CDualSlider::ChangeThumbColor(void)
  {
//--- Leave, if the form is blocked and the identifier of the currently active element differs
   if(m_wnd.IsLocked() && !CElement::CheckIdActivatedElement())
      return;
//--- If the cursor is in the left slider runner area
   if(m_left_thumb.MouseFocus())
     {
      //--- If the left mouse button is released
      if(m_clamping_mouse_left_thumb==NOT_PRESSED)
        {
         m_slider_thumb_state=false;
         m_left_thumb.Color(m_thumb_color_hover);
         m_left_thumb.BackColor(m_thumb_color_hover);
         return;
        }
      //--- Left mouse button is pressed
      else if(m_clamping_mouse_left_thumb==PRESSED_INSIDE)
        {
         m_slider_thumb_state=true;
         m_left_thumb.Color(m_thumb_color_pressed);
         m_left_thumb.BackColor(m_thumb_color_pressed);
         return;
        }
     }
//--- If the cursor is outside the left slider runner area
   else
     {
      //--- Left mouse button is released
      if(!m_mouse.LeftButtonState())
        {
         m_slider_thumb_state=false;
         m_left_thumb.Color(m_thumb_color);
         m_left_thumb.BackColor(m_thumb_color);
        }
     }
//--- If the cursor is in the right slider runner area
   if(m_right_thumb.MouseFocus())
     {
      //--- If the left mouse button is released     
      if(m_clamping_mouse_right_thumb==NOT_PRESSED)
        {
         m_slider_thumb_state=false;
         m_right_thumb.Color(m_thumb_color_hover);
         m_right_thumb.BackColor(m_thumb_color_hover);
         return;
        }
      //--- Left mouse button is pressed
      else if(m_clamping_mouse_right_thumb==PRESSED_INSIDE)
        {
         m_slider_thumb_state=true;
         m_right_thumb.Color(m_thumb_color_pressed);
         m_right_thumb.BackColor(m_thumb_color_pressed);
         return;
        }
     }
//--- If the cursor is outside the right slider runner area
   else
     {
      //--- Left mouse button is released
      if(!m_mouse.LeftButtonState())
        {
         m_slider_thumb_state=false;
         m_right_thumb.Color(m_thumb_color);
         m_right_thumb.BackColor(m_thumb_color);
        }
     }
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CDualSlider::Moving(const int x,const int y,const bool moving_mode=false)
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
      m_area.X(m_wnd.X2()-m_area.XGap());
      m_label.X(m_wnd.X2()-m_label.XGap());
      m_left_edit.X(m_wnd.X2()-m_left_edit.XGap());
      m_right_edit.X(m_wnd.X2()-m_right_edit.XGap());
      m_indicator.X(m_wnd.X2()-m_indicator.XGap());
      m_left_thumb.X(m_wnd.X2()-m_left_thumb.XGap());
      m_right_thumb.X(m_wnd.X2()-m_right_thumb.XGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::X(x+XGap());
      //--- Storing coordinates in the fields of the objects
      m_area.X(x+m_area.XGap());
      m_label.X(x+m_label.XGap());
      m_left_edit.X(x+m_left_edit.XGap());
      m_right_edit.X(x+m_right_edit.XGap());
      m_indicator.X(x+m_indicator.XGap());
      m_left_thumb.X(x+m_left_thumb.XGap());
      m_right_thumb.X(x+m_right_thumb.XGap());
     }
//--- If the anchored to the bottom
   if(m_anchor_bottom_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(m_wnd.Y2()-YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(m_wnd.Y2()-m_area.YGap());
      m_label.Y(m_wnd.Y2()-m_label.YGap());
      m_left_edit.Y(m_wnd.Y2()-m_left_edit.YGap());
      m_right_edit.Y(m_wnd.Y2()-m_right_edit.YGap());
      m_indicator.Y(m_wnd.Y2()-m_indicator.YGap());
      m_left_thumb.Y(m_wnd.Y2()-m_left_thumb.YGap());
      m_right_thumb.Y(m_wnd.Y2()-m_right_thumb.YGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::Y(y+YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(y+m_area.YGap());
      m_label.Y(y+m_label.YGap());
      m_left_edit.Y(y+m_left_edit.YGap());
      m_right_edit.Y(y+m_right_edit.YGap());
      m_indicator.Y(y+m_indicator.YGap());
      m_left_thumb.Y(y+m_left_thumb.YGap());
      m_right_thumb.Y(y+m_right_thumb.YGap());
     }
//--- Updating coordinates of graphical objects  
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_left_edit.X_Distance(m_left_edit.X());
   m_left_edit.Y_Distance(m_left_edit.Y());
   m_right_edit.X_Distance(m_right_edit.X());
   m_right_edit.Y_Distance(m_right_edit.Y());
   m_indicator.X_Distance(m_indicator.X());
   m_indicator.Y_Distance(m_indicator.Y());
   m_left_thumb.X_Distance(m_left_thumb.X());
   m_left_thumb.Y_Distance(m_left_thumb.Y());
   m_right_thumb.X_Distance(m_right_thumb.X());
   m_right_thumb.Y_Distance(m_right_thumb.Y());
//--- Moving the slot
   m_slot.Moving(x,y,true);
  }
//+------------------------------------------------------------------+
//| Shows a menu item                                                |
//+------------------------------------------------------------------+
void CDualSlider::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElementBase::IsVisible())
      return;
//--- Make all the objects visible
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Show the slot
   m_slot.Show();
//--- Visible state
   CElementBase::IsVisible(true);
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Hides a menu item                                                |
//+------------------------------------------------------------------+
void CDualSlider::Hide(void)
  {
//--- Leave, if the element is already visible
   if(!CElementBase::IsVisible())
      return;
//--- Hide all objects
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Hide the slot
   m_slot.Hide();
//--- Visible state
   CElementBase::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CDualSlider::Reset(void)
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
void CDualSlider::Delete(void)
  {
//--- Removing objects  
   m_area.Delete();
   m_label.Delete();
   m_left_edit.Delete();
   m_right_edit.Delete();
   m_slot.Delete();
   m_indicator.Delete();
   m_left_thumb.Delete();
   m_right_thumb.Delete();
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::MouseFocus(false);
   CElementBase::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CDualSlider::SetZorders(void)
  {
//--- Leave, if the element is blocked
   if(!m_slider_state)
      return;
//--- Set the default values
   m_area.Z_Order(m_area_zorder);
   m_label.Z_Order(m_zorder);
   m_left_edit.Z_Order(m_edit_zorder);
   m_right_edit.Z_Order(m_edit_zorder);
   m_indicator.Z_Order(m_zorder);
   m_left_thumb.Z_Order(m_zorder);
   m_right_thumb.Z_Order(m_zorder);
//--- The edit control in the edit mode
   m_left_edit.ReadOnly(false);
   m_right_edit.ReadOnly(false);
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CDualSlider::ResetZorders(void)
  {
//--- Leave, if the element is blocked
   if(!m_slider_state)
      return;
//--- Zeroing priorities
   m_area.Z_Order(0);
   m_label.Z_Order(0);
   m_left_edit.Z_Order(0);
   m_right_edit.Z_Order(0);
   m_indicator.Z_Order(0);
   m_left_thumb.Z_Order(0);
   m_right_thumb.Z_Order(0);
//--- Edit in the read only mode
   m_left_edit.ReadOnly(true);
   m_right_edit.ReadOnly(true);
  }
//+------------------------------------------------------------------+
//| End of entering the value                                        |
//+------------------------------------------------------------------+
bool CDualSlider::OnEndEdit(const string object_name)
  {
//--- If the value is entered in the left edit
   if(object_name==m_left_edit.Name())
     {
      //--- Get the entered value
      double entered_value=::StringToDouble(m_left_edit.Description());
      //--- Check, adjust and store the new value
      ChangeLeftValue(entered_value);
      //--- Calculate the X coordinate of the slider runner
      CalculateLeftThumbX();
      //--- Updating the slider runner location
      UpdateLeftThumb(m_left_thumb.X());
      //--- Calculate the position in the value range
      CalculateLeftThumbPos();
      //--- Setting a new value in the edit
      ChangeLeftValue(m_left_current_pos);
      //--- Update the slider indicator
      UpdateIndicator();
      //--- Send a message about it
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElementBase::Id(),CElementBase::Index(),m_label.Description());
      return(true);
     }
//--- If the value is entered in the right entry field
   if(object_name==m_right_edit.Name())
     {
      //--- Get the entered value
      double entered_value=::StringToDouble(m_right_edit.Description());
      //--- Check, adjust and store the new value
      ChangeRightValue(entered_value);
      //--- Calculate the X coordinate of the slider runner
      CalculateRightThumbX();
      //--- Updating the slider runner location
      UpdateRightThumb(m_right_thumb.X());
      //--- Calculate the position in the value range
      CalculateRightThumbPos();
      //--- Setting a new value in the edit
      ChangeRightValue(m_right_current_pos);
      //--- Update the slider indicator
      UpdateIndicator();
      //--- Send a message about it
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElementBase::Id(),CElementBase::Index(),m_label.Description());
      return(true);
     }
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Process of the left slider runner movement                       |
//+------------------------------------------------------------------+
void CDualSlider::OnDragLeftThumb(const int x)
  {
//--- To identify the new X coordinate  
   int new_x_point=0;
//--- If the slider runner is inactive, ...
   if(!m_slider_thumb_state)
     {
      //--- ...zero auxiliary variables for moving the slider
      m_slider_point_fixing =0;
      m_slider_size_fixing  =0;
      return;
     }
//--- If the fixation point is zero, store current coordinates of the cursor
   if(m_slider_point_fixing==0)
      m_slider_point_fixing=x;
//--- If the distance from the edge of the slider to the current coordinate of the cursor is zero, calculate it
   if(m_slider_size_fixing==0)
      m_slider_size_fixing=m_left_thumb.X()-x;
//--- If the threshold is passed to the right in the pressed down state
   if(x-m_slider_point_fixing>0)
     {
      //--- Calculate the X coordinate
      new_x_point=x+m_slider_size_fixing;
      //--- Updating the scrollbar location
      UpdateLeftThumb(new_x_point);
      return;
     }
//--- If the threshold is passed to the left in the pressed down state
   if(x-m_slider_point_fixing<0)
     {
      //--- Calculate the X coordinate
      new_x_point=x-::fabs(m_slider_size_fixing);
      //--- Updating the scrollbar location
      UpdateLeftThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Process of the right slider runner movement                      |
//+------------------------------------------------------------------+
void CDualSlider::OnDragRightThumb(const int x)
  {
//--- To identify the new X coordinate  
   int new_x_point=0;
//--- If the slider runner is inactive, ...
   if(!m_slider_thumb_state)
     {
      //--- ...zero auxiliary variables for moving the slider
      m_slider_point_fixing =0;
      m_slider_size_fixing  =0;
      return;
     }
//--- If the fixation point is zero, store current coordinates of the cursor
   if(m_slider_point_fixing==0)
      m_slider_point_fixing=x;
//--- If the distance from the edge of the slider to the current coordinate of the cursor is zero, calculate it
   if(m_slider_size_fixing==0)
      m_slider_size_fixing=m_right_thumb.X()-x;
//--- If the threshold is passed to the right in the pressed down state
   if(x-m_slider_point_fixing>0)
     {
      //--- Calculate the X coordinate
      new_x_point=x+m_slider_size_fixing;
      //--- Updating the scrollbar location
      UpdateRightThumb(new_x_point);
      return;
     }
//--- If the threshold is passed to the left in the pressed down state
   if(x-m_slider_point_fixing<0)
     {
      //--- Calculate the X coordinate
      new_x_point=x-::fabs(m_slider_size_fixing);
      //--- Updating the scrollbar location
      UpdateRightThumb(new_x_point);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Updating the left slider runner location                         |
//+------------------------------------------------------------------+
void CDualSlider::UpdateLeftThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- Zeroing the fixation point
   m_slider_point_fixing=0;
//--- Check for exceeding the working area
   if(new_x_point<m_area.X())
      x=m_area.X();
   int right_limit=m_right_thumb.X()-m_right_thumb.XSize();
   if(new_x_point>=right_limit)
      x=right_limit-1;
//--- Update the list view and scrollbar
   m_left_thumb.X(x);
   m_left_thumb.X_Distance(x);
//--- Store margins
   m_left_thumb.XGap((m_anchor_right_window_side)? m_wnd.X2()-(m_area.X2()-(m_area.X2()-m_left_thumb.X())) : m_left_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Updating the right slider runner location                        |
//+------------------------------------------------------------------+
void CDualSlider::UpdateRightThumb(const int new_x_point)
  {
   int x=new_x_point;
//--- Zeroing the fixation point
   m_slider_point_fixing=0;
//--- Check for exceeding the working area
   int right_limit=m_area.X2()-m_right_thumb.XSize();
   if(new_x_point>right_limit)
      x=right_limit;
   if(new_x_point<=m_left_thumb.X2())
      x=m_left_thumb.X2()+1;
//--- Update the list view and scrollbar
   m_right_thumb.X(x);
   m_right_thumb.X_Distance(x);
//--- Store margins
   m_right_thumb.XGap((m_anchor_right_window_side)? m_wnd.X2()-(m_area.X2()-(m_area.X2()-m_right_thumb.X())) : m_right_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Calculation of values (steps and coefficients)                   |
//+------------------------------------------------------------------+
bool CDualSlider::CalculateCoefficients(void)
  {
//--- Leave, if the width of the element is less than the width of the slider runner
   if(CElementBase::XSize()<m_thumb_x_size*2+1)
      return(false);
//--- Number of pixels in the working area
   m_pixels_total=CElementBase::XSize()-m_thumb_x_size;
//--- Number of steps in the value range of the working area
   m_value_steps_total=int((m_max_value-m_min_value)/m_step_value);
//--- Step in relation to the width of the working area
   m_position_step=m_step_value*(double(m_value_steps_total)/double(m_pixels_total));
   return(true);
  }
//+------------------------------------------------------------------+
//| Calculating the X coordinate of the left slider runner           |
//+------------------------------------------------------------------+
void CDualSlider::CalculateLeftThumbX(void)
  {
//--- Adjustment considering that the minimum value can be negative
   double neg_range=(m_min_value<0)? ::fabs(m_min_value/m_position_step) : 0;
//--- Calculate the X coordinate for the slider runner
   m_left_current_pos_x=m_area.X()+(m_left_edit_value/m_position_step)+neg_range;
//--- If the working area is exceeded on the left
   if(m_left_current_pos_x<m_area.X())
      m_left_current_pos_x=m_area.X();
//--- If the working area is exceeded on the right
   if(m_left_current_pos_x>m_right_thumb.X())
      m_left_current_pos_x=m_right_thumb.X()-m_left_thumb.XSize();
//--- Store and set the new X coordinate
   m_left_thumb.X(int(m_left_current_pos_x));
   m_left_thumb.X_Distance(int(m_left_current_pos_x));
   m_left_thumb.XGap((m_anchor_right_window_side)? m_wnd.X2()-(m_area.X2()-(m_area.X2()-m_left_thumb.X())) : m_left_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Calculating the X coordinate of the right slider runner          |
//+------------------------------------------------------------------+
void CDualSlider::CalculateRightThumbX(void)
  {
//--- Adjustment considering that the minimum value can be negative
   double neg_range=(m_min_value<0)? ::fabs(m_min_value/m_position_step) : 0;
//--- Calculate the X coordinate for the slider runner
   m_right_current_pos_x=m_area.X()+(m_right_edit_value/m_position_step)+neg_range;
//--- If the working area is exceeded on the left
   if(m_right_current_pos_x<m_area.X())
      m_right_current_pos_x=m_area.X();
//--- If the working area is exceeded on the right
   if(m_right_current_pos_x+m_right_thumb.XSize()>m_area.X2())
      m_right_current_pos_x=m_area.X2()-m_right_thumb.XSize();
//--- Store and set the new X coordinate
   m_right_thumb.X(int(m_right_current_pos_x));
   m_right_thumb.X_Distance(int(m_right_current_pos_x));
   m_right_thumb.XGap((m_anchor_right_window_side)? m_wnd.X2()-(m_area.X2()-(m_area.X2()-m_right_thumb.X())) : m_right_thumb.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
//| Changes position of the left slider runner in relation to value  |
//+------------------------------------------------------------------+
void CDualSlider::CalculateLeftThumbPos(void)
  {
//--- Get the position number of the slider runner
   m_left_current_pos=(m_left_thumb.X()-m_area.X())*m_position_step;
//--- Adjustment considering that the minimum value can be negative
   if(m_min_value<0 && m_left_current_pos_x!=WRONG_VALUE)
      m_left_current_pos+=int(m_min_value);
//--- Check for exceeding the working area on the left
   if(m_left_thumb.X()<=m_area.X())
      m_left_current_pos=int(m_min_value);
  }
//+------------------------------------------------------------------+
//| Changes position of the right slider runner in relation to value |
//+------------------------------------------------------------------+
void CDualSlider::CalculateRightThumbPos(void)
  {
//--- Get the position number of the slider runner
   m_right_current_pos=(m_right_thumb.X()-m_area.X())*m_position_step;
//--- Adjustment considering that the minimum value can be negative
   if(m_min_value<0 && m_right_current_pos_x!=WRONG_VALUE)
      m_right_current_pos+=int(m_min_value);
//--- Check for exceeding the working area on the right
   if(m_right_thumb.X2()>=m_area.X2())
      m_right_current_pos=int(m_max_value);
  }
//+------------------------------------------------------------------+
//| Zeroing variables connected with the slider runner movement      |
//+------------------------------------------------------------------+
void CDualSlider::ZeroThumbVariables(void)
  {
//--- If you are here, it means that the left mouse button is released.
//    If the left mouse button was pressed over the slider runner...
   if(m_clamping_mouse_left_thumb==PRESSED_INSIDE || 
      m_clamping_mouse_right_thumb==PRESSED_INSIDE)
     {
      //--- ... send a message that changing of the value in the entry field with the sider runner is completed
      ::EventChartCustom(m_chart_id,ON_END_EDIT,CElementBase::Id(),CElementBase::Index(),m_label.Description());
     }
//---
   m_slider_size_fixing         =0;
   m_clamping_mouse_left_thumb  =NOT_PRESSED;
   m_clamping_mouse_right_thumb =NOT_PRESSED;
//--- If the element identifier matches the activating identifier,
//    unblock the form and reset the identifier of the activated element
   if(CElement::CheckIdActivatedElement())
     {
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
     }
  }
//+------------------------------------------------------------------+
//| Checking the mouse button state                                  |
//+------------------------------------------------------------------+
void CDualSlider::CheckMouseOnLeftThumb(void)
  {
//--- If the left mouse button is released
   if(!m_mouse.LeftButtonState())
     {
      //--- Zero variables
      ZeroThumbVariables();
      return;
     }
//--- If the left mouse button is pressed
   else
     {
      //--- Leave, if the button is pressed down in another area
      if(m_clamping_mouse_left_thumb!=NOT_PRESSED)
         return;
      //--- Outside of the scrollbar area
      if(!m_left_thumb.MouseFocus())
         m_clamping_mouse_left_thumb=PRESSED_OUTSIDE;
      //--- Inside the scrollbar area
      else
        {
         //--- If inside the scrollbar
         m_clamping_mouse_left_thumb=PRESSED_INSIDE;
         //--- Block the form and store the active element identifier
         m_wnd.IsLocked(true);
         m_wnd.IdActivatedElement(CElementBase::Id());
        }
     }
  }
//+------------------------------------------------------------------+
//| Checking the mouse button state                                  |
//+------------------------------------------------------------------+
void CDualSlider::CheckMouseOnRightThumb(void)
  {
//--- If the left mouse button is released
   if(!m_mouse.LeftButtonState())
     {
      //--- Zero variables
      ZeroThumbVariables();
      return;
     }
//--- If the left mouse button is pressed
   else
     {
      //--- Leave, if the button is pressed down in another area
      if(m_clamping_mouse_right_thumb!=NOT_PRESSED)
         return;
      //--- Outside of the scrollbar area
      if(!m_right_thumb.MouseFocus())
         m_clamping_mouse_right_thumb=PRESSED_OUTSIDE;
      //--- Inside the scrollbar area
      else
        {
         //--- If inside the scrollbar
         m_clamping_mouse_right_thumb=PRESSED_INSIDE;
         //--- Block the form and store the active element identifier
         m_wnd.IsLocked(true);
         m_wnd.IdActivatedElement(CElementBase::Id());
        }
     }
  }
//+------------------------------------------------------------------+
//| Updating the slider indicator                                    |
//+------------------------------------------------------------------+
void CDualSlider::UpdateIndicator(void)
  {
//--- Calculate the size
   int x_size=m_right_thumb.X()-m_left_thumb.X();
//--- Adjustment in case of impermissible values
   if(x_size<=0)
      x_size=1;
//--- Set new values. (1) Coordinates, (2) size, (3) margin
   m_indicator.X(m_left_thumb.X2());
   m_indicator.X_Distance(m_left_thumb.X2());
   m_indicator.X_Size(x_size);
   m_indicator.XGap((m_anchor_right_window_side)? m_wnd.X2()-(m_area.X2()-(m_area.X2()-m_left_thumb.X())) : m_indicator.X()-m_wnd.X());
  }
//+------------------------------------------------------------------+
