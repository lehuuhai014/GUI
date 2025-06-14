//+------------------------------------------------------------------+
//|                                                CheckComboBox.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
#include "ListView.mqh"
//+------------------------------------------------------------------+
//| Class for creating a combobox with a checkbox                    |
//+------------------------------------------------------------------+
class CCheckComboBox : public CElement
  {
private:
   //--- Objects for creating a combobox
   CRectLabel        m_area;
   CBmpLabel         m_check;
   CLabel            m_label;
   CEdit             m_button;
   CBmpLabel         m_drop_arrow;
   CListView         m_listview;
   //--- Color of the element background
   color             m_area_color;
   //--- Checkbox icons in the active and blocked states
   string            m_check_bmp_file_on;
   string            m_check_bmp_file_off;
   string            m_check_bmp_file_on_locked;
   string            m_check_bmp_file_off_locked;
   //--- State of the checkbox button
   bool              m_check_button_state;
   //--- Text of the checkbox
   string            m_label_text;
   //--- Text label margins
   int               m_label_x_gap;
   int               m_label_y_gap;
   //--- Colors of the text label in different states
   color             m_label_color;
   color             m_label_color_off;
   color             m_label_color_hover;
   color             m_label_color_locked;
   color             m_label_color_array[];
   //--- (1) Button text and (2) its size
   string            m_button_text;
   int               m_button_x_size;
   int               m_button_y_size;
   //--- Colors of the button in different states
   color             m_button_color;
   color             m_button_color_hover;
   color             m_button_color_locked;
   color             m_button_color_pressed;
   color             m_button_color_array[];
   //--- Colors of the button frame in different states
   color             m_button_border_color;
   color             m_button_border_color_hover;
   color             m_button_border_color_locked;
   color             m_button_border_color_array[];
   //--- Color of the button text in different states
   color             m_button_text_color;
   color             m_button_text_color_locked;
   //--- Icon margins
   int               m_drop_arrow_x_gap;
   int               m_drop_arrow_y_gap;
   //--- Icons of the button with a drop-down menu in the active and blocked states
   string            m_drop_arrow_file_on;
   string            m_drop_arrow_file_locked;
   //--- Priorities of the left mouse button click
   int               m_zorder;
   int               m_area_zorder;
   int               m_combobox_zorder;
   //--- Checkbox state (available/blocked)
   bool              m_checkcombobox_state;
   //---
public:
                     CCheckComboBox(void);
                    ~CCheckComboBox(void);
   //--- Methods for creating a combobox
   bool              CreateCheckComboBox(const long chart_id,const int subwin,const string text,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateArea(void);
   bool              CreateCheck(void);
   bool              CreateLabel(void);
   bool              CreateButton(void);
   bool              CreateDropArrow(void);
   bool              CreateList(void);
   //---
public:
   //--- Returns pointers to (2) the list view and (3) the scrollbar
   CListView        *GetListViewPointer(void)                                 { return(::GetPointer(m_listview));                }
   CScrollV         *GetScrollVPointer(void)                                  { return(m_listview.GetScrollVPointer());          }
   //--- Setting (1) the size of the list view (number of items) and (2) its visible part, (3) getting and setting the element state
   void              ItemsTotal(const int items_total)                        { m_listview.ListSize(items_total);                }
   void              VisibleItemsTotal(const int visible_items_total)         { m_listview.VisibleListSize(visible_items_total); }
   bool              CheckComboBoxState(void)                           const { return(m_checkcombobox_state);                   }
   void              CheckComboBoxState(const bool state);
   //--- (1) Background color, (2) return/set the text label value, (3) gets/sets the state of the checkbox button
   void              AreaColor(const color clr)                               { m_area_color=clr;                                }
   string            LabelText(void)                                    const { return(m_label.Description());                   }
   void              LabelText(const string text)                             { m_label.Description(text);                       }
   bool              CheckButtonState(void)                             const { return(m_check.State());                         }
   void              CheckButtonState(const bool state);
   //--- Text label margins
   void              LabelXGap(const int x_gap)                               { m_label_x_gap=x_gap;                             }
   void              LabelYGap(const int y_gap)                               { m_label_y_gap=y_gap;                             }
   //--- Colors of the text label
   void              LabelColor(const color clr)                              { m_label_color=clr;                               }
   void              LabelColorOff(const color clr)                           { m_label_color_off=clr;                           }
   void              LabelColorHover(const color clr)                         { m_label_color_hover=clr;                         }
   void              LabelColorLocked(const color clr)                        { m_label_color_locked=clr;                        }
   //--- (1) Returns the button text, (2) setting the button size
   string            ButtonText(void)                                   const { return(m_button_text);                           }
   void              ButtonXSize(const int x_size)                            { m_button_x_size=x_size;                          }
   void              ButtonYSize(const int y_size)                            { m_button_y_size=y_size;                          }
   //--- Button colors
   void              ButtonBackColor(const color clr)                         { m_button_color=clr;                              }
   void              ButtonBackColorHover(const color clr)                    { m_button_color_hover=clr;                        }
   void              ButtonBackColorLocked(const color clr)                   { m_button_color_locked=clr;                       }
   void              ButtonBackColorPressed(const color clr)                  { m_button_color_pressed=clr;                      }
   //--- Colors of the button frame
   void              ButtonBorderColor(const color clr)                       { m_button_border_color=clr;                       }
   void              ButtonBorderColorLocked(const color clr)                 { m_button_border_color_locked=clr;                }
   //--- Colors of the button text 
   void              ButtonTextColor(const color clr)                         { m_button_text_color=clr;                         }
   void              ButtonTextColorLocked(const color clr)                   { m_button_text_color_locked=clr;                  }
   //--- Setting icons for the button with a drop-down menu in the active and blocked states
   void              DropArrowFileOn(const string file_path)                  { m_drop_arrow_file_on=file_path;                  }
   void              DropArrowFileLocked(const string file_path)              { m_drop_arrow_file_locked=file_path;              }
   //--- Icon margins
   void              DropArrowXGap(const int x_gap)                           { m_drop_arrow_x_gap=x_gap;                        }
   void              DropArrowYGap(const int y_gap)                           { m_drop_arrow_y_gap=y_gap;                        }

   //--- Stores the passed value in the list view by specified index
   void              SetItemValue(const int item_index,const string item_text);
   //--- Highlighting the item by specified index
   void              SelectedItemByIndex(const int value);
   //--- Changing the object color when the cursor is hovering over it
   void              ChangeObjectsColor(void);
   //--- Changes the current state of the combobox for the opposite
   void              ChangeComboBoxListState(void);
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
   //--- Handling of pressing the checkbox button
   bool              OnClickLabel(const string clicked_object);
   //--- Handling of pressing the combobox button
   bool              OnClickButton(const string clicked_object);
   //--- Checking the pressed left mouse button over the combobox button
   void              CheckPressedOverButton(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCheckComboBox::CCheckComboBox(void) : m_checkcombobox_state(true),
                                       m_check_button_state(false),
                                       m_area_color(clrNONE),
                                       m_check_bmp_file_on(""),
                                       m_check_bmp_file_off(""),
                                       m_check_bmp_file_on_locked(""),
                                       m_check_bmp_file_off_locked(""),
                                       m_label_text("check_combobox: "),
                                       m_label_x_gap(20),
                                       m_label_y_gap(2),
                                       m_label_color(clrBlack),
                                       m_label_color_off(clrBlack),
                                       m_label_color_locked(clrSilver),
                                       m_label_color_hover(C'85,170,255'),
                                       m_button_y_size(18),
                                       m_button_text(""),
                                       m_button_text_color(clrBlack),
                                       m_button_text_color_locked(clrDarkGray),
                                       m_button_color(C'220,220,220'),
                                       m_button_color_hover(C'193,218,255'),
                                       m_button_color_locked(C'230,230,230'),
                                       m_button_color_pressed(clrLightSteelBlue),
                                       m_button_border_color(clrSilver),
                                       m_button_border_color_hover(C'85,170,255'),
                                       m_button_border_color_locked(clrSilver),
                                       m_drop_arrow_x_gap(16),
                                       m_drop_arrow_y_gap(1),
                                       m_drop_arrow_file_on(""),
                                       m_drop_arrow_file_locked("")
  {
//--- Store the name of the element class in the base class
   CElementBase::ClassName(CLASS_NAME);
//--- Drop-down list view mode
   m_listview.IsDropdown(true);
//--- Set priorities of the left mouse button click
   m_zorder          =0;
   m_area_zorder     =1;
   m_combobox_zorder =2;
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCheckComboBox::~CCheckComboBox(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CCheckComboBox::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_button.MouseFocus(m_mouse.X()>m_button.X() && m_mouse.X()<m_button.X2() && 
                          m_mouse.Y()>m_button.Y() && m_mouse.Y()<m_button.Y2());
      //--- Leave, if the element is blocked
      if(!m_checkcombobox_state)
         return;
      //--- Leave, if the left mouse button is released
      if(!m_mouse.LeftButtonState())
         return;
      //--- Check of the pressed left mouse button over a split button
      CheckPressedOverButton();
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LIST_ITEM)
     {
      //--- If the group identifiers match
      if(lparam==CElementBase::Id())
        {
         //--- Store and set the text in the button
         m_button_text=m_listview.SelectedItemText();
         m_button.Description(m_listview.SelectedItemText());
         //--- Change the list view state
         ChangeComboBoxListState();
         //--- Send a message about it
         ::EventChartCustom(m_chart_id,ON_CLICK_COMBOBOX_ITEM,CElementBase::Id(),0,m_label_text);
        }
      //---
      return;
     }
//--- Handling the left mouse button click on the object
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Leave, if the element is blocked
      if(!m_checkcombobox_state)
         return;
      //--- Pressing on the checkbox button
      if(OnClickLabel(sparam))
         return;
      //--- Pressing on the combobox button
      if(OnClickButton(sparam))
         return;
      //---
      return;
     }
//--- Handling the chart properties change event
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      //--- Leave, if the element is blocked
      if(!m_checkcombobox_state)
         return;
      //--- Hide the list view
      m_listview.Hide();
      //--- Restore colors
      ResetColors();
      //--- Unblock the form
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CCheckComboBox::OnEventTimer(void)
  {
//--- If this is a drop-down element and the list view is hidden
   if(CElementBase::IsDropdown() && !m_listview.IsVisible())
      ChangeObjectsColor();
   else
     {
      //--- If the form and the element are not blocked
      if(!m_wnd.IsLocked() && m_checkcombobox_state)
         ChangeObjectsColor();
     }
  }
//+------------------------------------------------------------------+
//| Create "Combobox with button" control                            |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateCheckComboBox(const long chart_id,const int subwin,const string text,const int x_gap,const int y_gap)
  {
//--- Exit if there is no pointer to the form
   if(!CElement::CheckWindowPointer())
      return(false);
//--- Initializing variables
   m_id         =m_wnd.LastId()+1;
   m_chart_id   =chart_id;
   m_subwin     =subwin;
   m_label_text =text;
   m_x          =CElement::CalculateX(x_gap);
   m_y          =CElement::CalculateY(y_gap);
   m_area_color =(m_area_color!=clrNONE)? m_area_color : m_wnd.WindowBgColor();
//--- Margins from the edge
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
//--- Creating an element
   if(!CreateArea())
      return(false);
   if(!CreateCheck())
      return(false);
   if(!CreateLabel())
      return(false);
   if(!CreateButton())
      return(false);
   if(!CreateDropArrow())
      return(false);
   if(!CreateList())
      return(false);
//--- Store and set the text in the button
   m_button_text=m_listview.SelectedItemText();
   m_button.Description(m_listview.SelectedItemText());
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates combobox area                                            |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateArea(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkcombobox_area_"+(string)CElementBase::Id();
//--- Set the object
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_button_y_size))
      return(false);
//--- Set properties
   m_area.BackColor(m_area_color);
   m_area.Color(m_area_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Margins from the edge
   m_area.XGap(CElement::CalculateXGap(m_x));
   m_area.YGap(CElement::CalculateYGap(m_y));
//--- Store the object pointer
   CElementBase::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox                                                 |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp"
//---
bool CCheckComboBox::CreateCheck(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkbox_bmp_"+(string)CElementBase::Id();
//--- Coordinates
   int x=m_x+2;
   int y=m_y+2;
//--- If the icon for the checkbox button is not specified, then set the default one
   if(m_check_bmp_file_on=="")
      m_check_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp";
   if(m_check_bmp_file_off=="")
      m_check_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp";
//---
   if(m_check_bmp_file_on_locked=="")
      m_check_bmp_file_on_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_locked.bmp";
   if(m_check_bmp_file_off_locked=="")
      m_check_bmp_file_off_locked="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff_locked.bmp";
//--- Set the object
   if(!m_check.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_check.BmpFileOn("::"+m_check_bmp_file_on);
   m_check.BmpFileOff("::"+m_check_bmp_file_off);
   m_check.State(m_check_button_state);
   m_check.Corner(m_corner);
   m_check.Selectable(false);
   m_check.Z_Order(m_zorder);
   m_check.Tooltip("\n");
//--- Margins from the edge
   m_check.XGap(CElement::CalculateXGap(x));
   m_check.YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_check);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates text label (brief description of the control)            |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateLabel(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkcombobox_lable_"+(string)CElementBase::Id();
//--- Coordinates
   int x=m_x+m_label_x_gap;
   int y=m_y+m_label_y_gap;
//--- Text color according to the state
   color label_color=(m_check_button_state)? m_label_color : m_label_color_off;
//--- Set the object
   if(!m_label.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_label.Description(m_label_text);
   m_label.Font(CElementBase::Font());
   m_label.FontSize(CElementBase::FontSize());
   m_label.Color(label_color);
   m_label.Corner(m_corner);
   m_label.Anchor(m_anchor);
   m_label.Selectable(false);
   m_label.Z_Order(m_zorder);
   m_label.Tooltip("\n");
//--- Margins from the edge
   m_label.XGap(CElement::CalculateXGap(x));
   m_label.YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(label_color,m_label_color_hover,m_label_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_label);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates button                                                   |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateButton(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkcombobox_button_"+(string)CElementBase::Id();
//--- Coordinates
   int x =m_x+m_x_size-m_button_x_size;
   int y =m_y-1;
//--- Set the object
   if(!m_button.Create(m_chart_id,name,m_subwin,x,y,m_button_x_size,m_button_y_size))
      return(false);
//--- Set properties
   m_button.Font(CElementBase::Font());
   m_button.FontSize(CElementBase::FontSize());
   m_button.Color(m_button_text_color);
   m_button.Description(m_button_text);
   m_button.BackColor(m_button_color);
   m_button.BorderColor(m_button_border_color);
   m_button.Corner(m_corner);
   m_button.Anchor(m_anchor);
   m_button.Selectable(false);
   m_button.Z_Order(m_combobox_zorder);
   m_button.ReadOnly(true);
   m_button.Tooltip("\n");
//--- Store coordinates
   m_button.X(x);
   m_button.Y(y);
//--- Store the size
   m_button.XSize(m_button_x_size);
   m_button.YSize(m_button_y_size);
//--- Margins from the edge
   m_button.XGap(CElement::CalculateXGap(x));
   m_button.YGap(CElement::CalculateYGap(y));
//--- Initializing the array gradient
   CElementBase::InitColorArray(m_button_color,m_button_color_hover,m_button_color_array);
   CElementBase::InitColorArray(m_button_border_color,m_button_border_color_hover,m_button_border_color_array);
//--- Store the object pointer
   CElementBase::AddToArray(m_button);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create arrow on the combobox                                     |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp"
//---
bool CCheckComboBox::CreateDropArrow(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkcombobox_drop_"+(string)CElementBase::Id();
//--- Coordinates
   int x =m_button.X()+m_button.XSize()-m_drop_arrow_x_gap;
   int y =m_button.Y()+m_drop_arrow_y_gap;
//--- If the icon for the arrow is not specified, then set the default one
   if(m_drop_arrow_file_on=="")
      m_drop_arrow_file_on="Images\\EasyAndFastGUI\\Controls\\DropOff_black.bmp";
   if(m_drop_arrow_file_locked=="")
      m_drop_arrow_file_locked="Images\\EasyAndFastGUI\\Controls\\DropOff.bmp";
//--- Set the object
   if(!m_drop_arrow.Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_drop_arrow.BmpFileOn("::"+m_drop_arrow_file_on);
   m_drop_arrow.BmpFileOff("::"+m_drop_arrow_file_locked);
   m_drop_arrow.State(true);
   m_drop_arrow.Corner(m_corner);
   m_drop_arrow.Selectable(false);
   m_drop_arrow.Z_Order(m_zorder);
   m_drop_arrow.Tooltip("\n");
//--- Store coordinates
   m_drop_arrow.X(x);
   m_drop_arrow.Y(y);
//--- Store the size
   m_drop_arrow.XSize(m_drop_arrow.X_Size());
   m_drop_arrow.YSize(m_drop_arrow.Y_Size());
//--- Margins from the edge
   m_drop_arrow.XGap(CElement::CalculateXGap(x));
   m_drop_arrow.YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_drop_arrow);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the list view                                            |
//+------------------------------------------------------------------+
bool CCheckComboBox::CreateList(void)
  {
//--- Store the pointers to form and this element
   m_listview.WindowPointer(m_wnd);
   m_listview.ComboBoxPointer(this);
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X2()-m_button_x_size);
   int y=CElement::CalculateYGap(m_y+m_button_y_size-1);
//--- Set properties before creation
   m_listview.Id(CElementBase::Id());
//--- Set the list view width
   m_listview.XSize(m_button_x_size);
   m_listview.AnchorRightWindowSide(m_anchor_right_window_side);
   m_listview.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Create control
   if(!m_listview.CreateListView(m_chart_id,m_subwin,x,y))
      return(false);
//--- Hide the list view
   m_listview.Hide();
   return(true);
  }
//+------------------------------------------------------------------+
//| Setting the state of the checkbox button                         |
//+------------------------------------------------------------------+
void CCheckComboBox::CheckButtonState(const bool state)
  {
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return;
//---
   m_check.State(state);
   m_check_button_state=state;
//---
   m_label.Color((state)? m_label_color : m_label_color_off);
   CElementBase::InitColorArray((state)? m_label_color : m_label_color_off,m_label_color_hover,m_label_color_array);
  }
//+------------------------------------------------------------------+
//| Adds list item                                                   |
//+------------------------------------------------------------------+
void CCheckComboBox::SetItemValue(const int item_index,const string item_text)
  {
   m_listview.SetItemValue(item_index,item_text);
  }
//+------------------------------------------------------------------+
//| Select the item by specified index                               |
//+------------------------------------------------------------------+
void CCheckComboBox::SelectedItemByIndex(const int index)
  {
//--- Select the item in the list view
   m_listview.SelectItem(index);
//--- Store and set the text in the button
   m_button_text=m_listview.SelectedItemText();
   m_button.Description(m_listview.SelectedItemText());
  }
//+------------------------------------------------------------------+
//| Changing the object color when the cursor is hovering over it    |
//+------------------------------------------------------------------+
void CCheckComboBox::ChangeObjectsColor(void)
  {
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return;
//---
   color label_color=(m_check_button_state) ? m_label_color : m_label_color_off;
   CElementBase::ChangeObjectColor(m_label.Name(),CElementBase::MouseFocus(),OBJPROP_COLOR,label_color,m_label_color_hover,m_label_color_array);
   CElementBase::ChangeObjectColor(m_button.Name(),CElementBase::MouseFocus(),OBJPROP_BGCOLOR,m_button_color,m_button_color_hover,m_button_color_array);
   CElementBase::ChangeObjectColor(m_button.Name(),CElementBase::MouseFocus(),OBJPROP_BORDER_COLOR,m_button_border_color,m_button_border_color_hover,m_button_border_color_array);
  }
//+------------------------------------------------------------------+
//| Changing the combobox state                                      |
//+------------------------------------------------------------------+
void CCheckComboBox::CheckComboBoxState(const bool state)
  {
//--- Control state
   m_checkcombobox_state=state;
//--- Checkbox icons
   m_check.BmpFileOn((state)? "::"+m_check_bmp_file_on : "::"+m_check_bmp_file_on_locked);
   m_check.BmpFileOff((state)? "::"+m_check_bmp_file_off : "::"+m_check_bmp_file_off_locked);
//--- Color of the text label
   m_label.Color((state)? m_label_color : m_label_color_locked);
//--- Button colors
   m_button.Color((state)? m_button_text_color : m_button_text_color_locked);
   m_button.BackColor((state)? m_button_color : m_button_color_locked);
   m_button.BorderColor((state)? m_button_border_color : m_button_border_color_locked);
//--- Arrow icon on the button
   m_drop_arrow.State(state);
  }
//+------------------------------------------------------------------+
//| Changes the current state of the combobox for the opposite       |
//+------------------------------------------------------------------+
void CCheckComboBox::ChangeComboBoxListState(void)
  {
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return;
//--- If the list view is visible
   if(m_listview.IsVisible())
     {
      //--- Hide the list view
      m_listview.Hide();
      //--- Set colors
      m_label.Color(m_label_color_hover);
      m_button.BackColor(m_button_color_hover);
      //--- If this is not a drop-down element
      if(!CElementBase::IsDropdown())
        {
         //--- Unblock the form
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
         //--- Send a signal to restore the priorities of the left mouse click
         ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,CElementBase::Id(),0.0,CElementBase::ClassName());
        }
     }
   else
     {
      //--- Show the list view
      m_listview.Show();
      //--- Set colors
      m_label.Color(m_label_color_hover);
      m_button.BackColor(m_button_color_pressed);
      //--- Block the form
      m_wnd.IsLocked(true);
      m_wnd.IdActivatedElement(CElementBase::Id());
     }
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CCheckComboBox::Moving(const int x,const int y,const bool moving_mode=false)
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
      m_check.X(m_wnd.X2()-m_check.XGap());
      m_label.X(m_wnd.X2()-m_label.XGap());
      m_button.X(m_wnd.X2()-m_button.XGap());
      m_drop_arrow.X(m_wnd.X2()-m_drop_arrow.XGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::X(x+XGap());
      //--- Storing coordinates in the fields of the objects
      m_area.X(x+m_area.XGap());
      m_check.X(x+m_check.XGap());
      m_label.X(x+m_label.XGap());
      m_button.X(x+m_button.XGap());
      m_drop_arrow.X(x+m_drop_arrow.XGap());
     }
//--- If the anchored to the bottom
   if(m_anchor_bottom_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(m_wnd.Y2()-YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(m_wnd.Y2()-m_area.YGap());
      m_check.Y(m_wnd.Y2()-m_check.YGap());
      m_label.Y(m_wnd.Y2()-m_label.YGap());
      m_button.Y(m_wnd.Y2()-m_button.YGap());
      m_drop_arrow.Y(m_wnd.Y2()-m_drop_arrow.YGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::Y(y+YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(y+m_area.YGap());
      m_check.Y(y+m_check.YGap());
      m_label.Y(y+m_label.YGap());
      m_button.Y(y+m_button.YGap());
      m_drop_arrow.Y(y+m_drop_arrow.YGap());
     }
//--- Updating coordinates of graphical objects  
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_check.X_Distance(m_check.X());
   m_check.Y_Distance(m_check.Y());
   m_label.X_Distance(m_label.X());
   m_label.Y_Distance(m_label.Y());
   m_button.X_Distance(m_button.X());
   m_button.Y_Distance(m_button.Y());
   m_drop_arrow.X_Distance(m_drop_arrow.X());
   m_drop_arrow.Y_Distance(m_drop_arrow.Y());
  }
//+------------------------------------------------------------------+
//| Shows combobox                                                   |
//+------------------------------------------------------------------+
void CCheckComboBox::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElementBase::IsVisible())
      return;
//--- Make all the objects visible
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Show the list view
   m_listview.Hide();
//--- Visible state
   CElementBase::IsVisible(true);
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Hides combobox                                                   |
//+------------------------------------------------------------------+
void CCheckComboBox::Hide(void)
  {
//--- Leave, if the element is already visible
   if(!CElementBase::IsVisible())
      return;
//--- Hide all objects
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Hide the list view
   m_listview.Hide();
//--- Visible state
   CElementBase::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CCheckComboBox::Reset(void)
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
void CCheckComboBox::Delete(void)
  {
//--- Removing objects  
   m_area.Delete();
   m_check.Delete();
   m_label.Delete();
   m_button.Delete();
   m_drop_arrow.Delete();
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::MouseFocus(false);
   CElementBase::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CCheckComboBox::SetZorders(void)
  {
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return;
//--- Set the default values
   m_area.Z_Order(m_area_zorder);
   m_check.Z_Order(m_zorder);
   m_label.Z_Order(m_zorder);
   m_button.Z_Order(m_combobox_zorder);
   m_drop_arrow.Z_Order(m_zorder);
   m_listview.SetZorders();
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CCheckComboBox::ResetZorders(void)
  {
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return;
//--- Zeroing priorities
   m_area.Z_Order(0);
   m_check.Z_Order(0);
   m_label.Z_Order(0);
   m_button.Z_Order(0);
   m_drop_arrow.Z_Order(0);
   m_listview.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Reset the color of the element objects                           |
//+------------------------------------------------------------------+
void CCheckComboBox::ResetColors(void)
  {
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return;
//--- Zero the color
   m_label.Color((m_check_button_state)? m_label_color : m_label_color_off);
   m_button.BackColor(m_button_color);
//--- Zero the focus
   CElementBase::MouseFocus(false);
  }
//+------------------------------------------------------------------+
//| Clicking on the element header                                   |
//+------------------------------------------------------------------+
bool CCheckComboBox::OnClickLabel(const string clicked_object)
  {
//--- Leave, if it has a different object name
   if(m_area.Name()!=clicked_object)
      return(false);
//--- Leave, if the element is blocked
   if(!m_checkcombobox_state)
      return(false);
//--- Change the checkbox button state for the opposite
   if(!m_check.State())
     {
      m_check.State(true);
      m_check_button_state=true;
      m_label.Color(m_label_color_hover);
      CElementBase::InitColorArray(m_label_color,m_label_color_hover,m_label_color_array);
     }
   else
     {
      m_check.State(false);
      m_check_button_state=false;
      m_label.Color(m_label_color_hover);
      CElementBase::InitColorArray(m_label_color_off,m_label_color_hover,m_label_color_array);
     }
//--- If the list view is visible
   if(m_listview.IsVisible())
     {
      //--- Hide the list view
      m_listview.Hide();
      //--- Change the button color
      m_button.BackColor(m_button_color_hover);
      //--- Unblock the form
      m_wnd.IsLocked(false);
      m_wnd.IdActivatedElement(WRONG_VALUE);
      //--- Send a signal to restore the priorities of the left mouse click
      ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,CElementBase::Id(),0.0,CElementBase::ClassName());
     }
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_CLICK_LABEL,(long)CElementBase::Id(),0,m_label.Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Pressing on the combobox button                                  |
//+------------------------------------------------------------------+
bool CCheckComboBox::OnClickButton(const string clicked_object)
  {
//--- Leave, if it has a different object name  
   if(clicked_object!=m_button.Name())
      return(false);
//--- Change the list view state
   ChangeComboBoxListState();
   return(true);
  }
//+------------------------------------------------------------------+
//| Check of the pressed left mouse button over the button           |
//+------------------------------------------------------------------+
void CCheckComboBox::CheckPressedOverButton(void)
  {
//--- Leave, if the form is blocked and identifiers do not match
   if(m_wnd.IsLocked() && !CElement::CheckIdActivatedElement())
      return;
//--- If there is no focus
   if(!CElementBase::MouseFocus())
     {
      //--- Leave, if the focus is not over the list view or the scrollbar is enabled
      if(m_listview.MouseFocus() || m_listview.ScrollState())
         return;
      //--- Hide the list view
      m_listview.Hide();
      //--- Restore colors
      ResetColors();
      //--- If identifiers match and the element is not a drop-down
      if(CElement::CheckIdActivatedElement() && !CElementBase::IsDropdown())
        {
         //--- Unblock the form
         m_wnd.IsLocked(false);
         m_wnd.IdActivatedElement(WRONG_VALUE);
         //--- Send a signal to restore the priorities of the left mouse click
         ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,CElementBase::Id(),0.0,CElementBase::ClassName());
        }
     }
//--- If there is focus
   else
     {
      //--- Leave, if the list view is visible
      if(m_listview.IsVisible())
         return;
      //--- Set the color considering the focus
      if(m_button.MouseFocus())
         m_button.BackColor(m_button_color_pressed);
      else
         m_button.BackColor(m_button_color_hover);
     }
  }
//+------------------------------------------------------------------+
