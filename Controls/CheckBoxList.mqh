//+------------------------------------------------------------------+
//|                                                 CheckBoxList.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| Class for creating a List of checkboxes                          |
//+------------------------------------------------------------------+
class CCheckBoxList : public CElement
  {
private:
   //--- Pointer to the element managing the list view visibility
   CElement         *m_combobox;
   //--- Objects for creating the list view
   CRectLabel        m_area;
   CEdit             m_items[];
   CBmpLabel         m_checks[];
   CLabel            m_labels[];
   CScrollV          m_scrollv;
   //--- Array of values and states of checkboxes in the list
   string            m_item_value[];
   bool              m_item_state[];
   //--- Size of the list view and its visible part
   int               m_items_total;
   int               m_visible_items_total;
   //--- Properties of the list view background
   int               m_area_zorder;
   color             m_area_border_color;
   //--- Checkbox icons
   string            m_check_bmp_file_on;
   string            m_check_bmp_file_off;
   //--- Properties of the list view items
   int               m_item_zorder;
   int               m_item_y_size;
   color             m_item_color;
   color             m_item_color_hover;
   color             m_item_text_color;
   color             m_item_text_color_hover;
   //--- Mode of highlighting when the cursor is hovering over
   bool              m_lights_hover;
   //--- Timer counter for fast forwarding the list view
   int               m_timer_counter;
   //--- To determine the moment of mouse cursor transition from one item to another
   int               m_prev_item_index_focus;
   //---
public:
                     CCheckBoxList(void);
                    ~CCheckBoxList(void);
   //--- Methods for creating the control
   bool              CreateCheckBoxList(const long chart_id,const int subwin,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateItem(const int index,const int x,const int y,const int width);
   bool              CreateCheck(const int index,const int x,const int y);
   bool              CreateLabel(const int index,const int x,const int y);
   bool              CreateArea(void);
   bool              CreateList(void);
   bool              CreateItems(void);
   bool              CreateChecks(void);
   bool              CreateLabels(void);
   bool              CreateScrollV(void);
   //---
public:
   //--- (1) Stores pointer to the combobox, (2) returns pointer to the scrollbar
   void              ComboBoxPointer(CElement &object)                   { m_combobox=::GetPointer(object); }
   CScrollV         *GetScrollVPointer(void)                             { return(::GetPointer(m_scrollv)); }
   //--- (1) Item height, returns (2) the size of the list view and (3) its visible part
   void              ItemYSize(const int y_size)                         { m_item_y_size=y_size;            }
   int               ItemsTotal(void)                              const { return(m_items_total);           }
   int               VisibleItemsTotal(void)                       const { return(m_visible_items_total);   }
   //--- (1) Background frame color, (2) mode of highlighting items when hovering, (3) text alignment mode
   void              AreaBorderColor(const color clr)                    { m_area_border_color=clr;         }
   void              LightsHover(const bool state)                       { m_lights_hover=state;            }
   //--- Color of the list view items in different states
   void              ItemColor(const color clr)                          { m_item_color=clr;                }
   void              ItemColorHover(const color clr)                     { m_item_color_hover=clr;          }
   void              ItemTextColor(const color clr)                      { m_item_text_color=clr;           }
   void              ItemTextColorHover(const color clr)                 { m_item_text_color_hover=clr;     }
   //--- Set the size of (1) the list view and (2) its visible part
   void              ListSize(const int items_total);
   void              VisibleListSize(const int visible_items_total);
   //--- Returns/stores the (1) state and (2) text of the list item at the specified index
   void              SetItemState(const uint item_index,const bool state);
   void              SetItemValue(const uint item_index,const string value);
   bool              GetItemState(const uint item_index);
   string            GetItemValue(const uint item_index);
   //--- Rebuilding the list
   void              Rebuilding(const int items_total,const int visible_items_total);
   //--- Add item to the list
   void              AddItem(const string value="",const bool state=false);
   //--- Clears the list (deletes all items)
   void              Clear(void);
   //--- Scrolling the list
   void              Scrolling(const int pos=WRONG_VALUE);
   //--- Resetting the color of the list view items
   void              ResetItemsColor(void);
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
   //--- Changing the color of list view items when the cursor is hovering over them
   void              ChangeItemsColor(void);
   //--- Checking the focus of list view items when the cursor is hovering
   void              CheckItemFocus(void);
   //--- Handling the pressing on the list view item
   bool              OnClickListItem(const string clicked_object);
   //--- Update the list
   void              UpdateList(const int pos=WRONG_VALUE);
   //--- Fast forward of the list view
   void              FastSwitching(void);

   //--- Calculation of the Y coordinate of the item
   int               CalculationItemY(const int item_index=0);
   //--- Calculating the width of items
   int               CalculationItemsWidth(void);
   //--- Calculation of the list size along the Y axis
   int               CalculationYSize(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCheckBoxList::CCheckBoxList(void) : m_item_y_size(19),
                                     m_lights_hover(false),
                                     m_items_total(2),
                                     m_visible_items_total(2),
                                     m_area_border_color(C'235,235,235'),
                                     m_check_bmp_file_on(""),
                                     m_check_bmp_file_off(""),
                                     m_item_color(clrWhite),
                                     m_item_color_hover(C'240,240,240'),
                                     m_item_text_color(clrBlack),
                                     m_item_text_color_hover(clrBlack),
                                     m_prev_item_index_focus(WRONG_VALUE)
  {
//--- Store the name of the element class in the base class
   CElementBase::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_area_zorder =1;
   m_item_zorder =2;
//--- Set the size of the list view and its visible part
   ListSize(m_items_total);
   VisibleListSize(m_visible_items_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCheckBoxList::~CCheckBoxList(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CCheckBoxList::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- If this is a drop-down list and the mouse button is pressed
      if(CElementBase::IsDropdown() && m_mouse.LeftButtonState())
        {
         //--- If the cursor is outside the combobox, outside the list view and not in scrolling mode
         if(!m_combobox.MouseFocus() && !CElementBase::MouseFocus() && !m_scrollv.ScrollState())
           {
            //--- Hide the list view
            Hide();
            return;
           }
        }
      //--- Move the list if the management of the slider is enabled
      if(m_scrollv.ScrollBarControl())
        {
         UpdateList();
         return;
        }
      //--- Reset color of the element, if not in focus
      if(!CElementBase::MouseFocus())
        {
         //--- If the item already is in focus
         if(m_prev_item_index_focus!=WRONG_VALUE)
           {
            //--- Reset the color of the list view
            ResetColors();
            m_prev_item_index_focus=WRONG_VALUE;
           }
         return;
        }
      //--- Changes the color of the list view items when the cursor is hovering over it
      ChangeItemsColor();
      return;
     }
//--- Handling the pressing on objects
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- If the pressing was on the list view elements
      if(OnClickListItem(sparam))
         return;
      //--- If the pressing was on the buttons of the scrollbar
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam))
        {
         //--- Moves the list along the scrollbar
         UpdateList();
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CCheckBoxList::OnEventTimer(void)
  {
//--- If the element is a drop-down
   if(CElementBase::IsDropdown())
      //--- Fast forward of the list view
      FastSwitching();
//--- If this is not a drop-down element, take current availability of the form into consideration
   else
     {
      //--- Track the fast forward of the list view only if the form is not blocked
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| Creates the list view                                            |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateCheckBoxList(const long chart_id,const int subwin,const int x_gap,const int y_gap)
  {
//--- Exit if there is no pointer to the form
   if(!CElement::CheckWindowPointer())
      return(false);
//--- If the list view is a drop-down, a pointer to the combobox to which it will be attached is required
   if(CElementBase::IsDropdown())
     {
      //--- Leave, if there is no pointer to the combobox
      if(::CheckPointer(m_combobox)==POINTER_INVALID)
        {
         ::Print(__FUNCTION__," > Before creating a drop-down list view, the class must be passed "
                 "a pointer to the combobox: CCheckBoxList::ComboBoxPointer(CElement &object)");
         return(false);
        }
     }
//--- Initializing variables
   m_id       =m_wnd.LastId()+1;
   m_chart_id =chart_id;
   m_subwin   =subwin;
   m_x        =CElement::CalculateX(x_gap);
   m_y        =CElement::CalculateY(y_gap);
   m_y_size   =CalculationYSize();
//--- Margins from the edge
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
//--- Creating a button
   if(!CreateArea())
      return(false);
   if(!CreateList())
      return(false);
   if(!CreateScrollV())
      return(false);
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized() || CElementBase::IsDropdown())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the list view background                                  |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateArea(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkboxlist_area_"+(string)CElementBase::Id();
//--- Creating the object
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Setting up properties
   m_area.BackColor(m_item_color);
   m_area.Color(m_area_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_area_zorder);
   m_area.Tooltip("\n");
//--- Store coordinates
   m_area.X(CElementBase::X());
   m_area.Y(CElementBase::Y());
//--- Store the size
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
//| Creates the list view                                            |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateList(void)
  {
   if(!CreateItems())
      return(false);
   if(!CreateChecks())
      return(false);
   if(!CreateLabels())
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates an item                                                  |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateItem(const int index,const int x,const int y,const int width)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkboxlist_item_"+(string)index+"__"+(string)CElementBase::Id();
//--- Creating the object
   if(!m_items[index].Create(m_chart_id,name,m_subwin,x,y,width,m_item_y_size))
      return(false);
//--- Setting up properties
   m_items[index].Description("");
   m_items[index].Font(CElementBase::Font());
   m_items[index].FontSize(CElementBase::FontSize());
   m_items[index].Color(m_item_color);
   m_items[index].BackColor(m_item_color);
   m_items[index].BorderColor(m_item_color);
   m_items[index].Corner(m_corner);
   m_items[index].Anchor(m_anchor);
   m_items[index].Selectable(false);
   m_items[index].Z_Order(m_item_zorder);
   m_items[index].ReadOnly(true);
   m_items[index].Tooltip("\n");
//--- Coordinates
   m_items[index].X(x);
   m_items[index].Y(y);
//--- Sizes
   m_items[index].XSize(width);
   m_items[index].YSize(m_item_y_size);
//--- Margins from the edge of the panel
   m_items[index].XGap(CElement::CalculateXGap(x));
   m_items[index].YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_items[index]);
//--- Hide the item, if the control is hidden
   if(!CElementBase::IsVisible())
      m_items[index].Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the list view items                                      |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateItems(void)
  {
//--- Coordinates
   int x =CElementBase::X()+1;
   int y =0;
//--- Calculating the width of the list view items
   int w=CalculationItemsWidth();
//---
   for(int i=0; i<m_items_total && i<m_visible_items_total; i++)
     {
      //--- Calculation of the Y coordinate
      y=CalculationItemY(i);
      //--- Creating the object
      if(!CreateItem(i,x,y,w))
         return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox                                                 |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateCheck(const int index,const int x,const int y)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkboxlist_check_"+(string)index+"__"+(string)CElementBase::Id();

//--- If the icon for the checkbox button is not specified, then set the default one
   if(m_check_bmp_file_on=="")
      m_check_bmp_file_on="Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp";
   if(m_check_bmp_file_off=="")
      m_check_bmp_file_off="Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp";
//--- Creating the object
   if(!m_checks[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Setting up properties
   m_checks[index].BmpFileOn("::"+m_check_bmp_file_on);
   m_checks[index].BmpFileOff("::"+m_check_bmp_file_off);
   m_checks[index].State(m_item_state[index]);
   m_checks[index].Corner(m_corner);
   m_checks[index].Selectable(false);
   m_checks[index].Z_Order(m_area_zorder);
   m_checks[index].Tooltip("\n");
//--- Coordinates
   m_checks[index].X(x);
   m_checks[index].Y(y);
//--- Margins from the edge of the panel
   m_checks[index].XGap(CElement::CalculateXGap(x));
   m_checks[index].YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_checks[index]);
//--- Hide the item, if the control is hidden
   if(!CElementBase::IsVisible())
      m_checks[index].Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkboxes of the list                                   |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOff.bmp"
//---
bool CCheckBoxList::CreateChecks(void)
  {
//--- Coordinates
   int x =CElementBase::X()+3;
   int y =0;
//---
   for(int i=0; i<m_items_total && i<m_visible_items_total; i++)
     {
      //--- Calculation of the Y coordinate
      y=m_items[i].Y()+3;
      //--- Creating the object
      if(!CreateCheck(i,x,y))
         return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the text label                                           |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateLabel(const int index,const int x,const int y)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_checkbox_lable_"+(string)index+"__"+(string)CElementBase::Id();
//--- Creating the object
   if(!m_labels[index].Create(m_chart_id,name,m_subwin,x,y))
      return(false);
//--- Set properties
   m_labels[index].Description(m_item_value[index]);
   m_labels[index].Font(CElementBase::Font());
   m_labels[index].FontSize(CElementBase::FontSize());
   m_labels[index].Color(clrBlack);
   m_labels[index].Corner(m_corner);
   m_labels[index].Anchor(m_anchor);
   m_labels[index].Selectable(false);
   m_labels[index].Z_Order(m_area_zorder);
   m_labels[index].Tooltip("\n");
//--- Coordinates
   m_labels[index].X(x);
   m_labels[index].Y(y);
//--- Margins from the edge
   m_labels[index].XGap(CElement::CalculateXGap(x));
   m_labels[index].YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_labels[index]);
//--- Hide the item, if the control is hidden
   if(!CElementBase::IsVisible())
      m_labels[index].Timeframes(OBJ_NO_PERIODS);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates text labels of the list                                  |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateLabels(void)
  {
//--- Coordinates
   int x =CElementBase::X()+20;
   int y =0;
//---
   for(int i=0; i<m_items_total && i<m_visible_items_total; i++)
     {
      //--- Coordinates
      y=m_items[i].Y()+3;
      //--- Creating the object
      if(!CreateLabel(i,x,y))
         return(false);
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the vertical scrollbar                                   |
//+------------------------------------------------------------------+
bool CCheckBoxList::CreateScrollV(void)
  {
//--- Store the form pointer
   m_scrollv.WindowPointer(m_wnd);
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X2()-m_scrollv.ScrollWidth());
   int y=CElement::CalculateYGap(CElementBase::Y());
//--- Set properties
   m_scrollv.Id(CElementBase::Id());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(CElementBase::YSize());
   m_scrollv.AreaBorderColor(m_area_border_color);
   m_scrollv.IsDropdown(CElementBase::IsDropdown());
   m_scrollv.AnchorRightWindowSide(m_anchor_right_window_side);
   m_scrollv.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Creating the scrollbar
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_items_total,m_visible_items_total))
      return(false);
//--- Update the position of objects
   m_scrollv.Moving(m_wnd.X(),m_wnd.Y(),true);
//--- Hide the scrollbar, if the number of items is less than the size of the list
   if(m_items_total<=m_visible_items_total)
      m_scrollv.Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Setting the state                                                |
//+------------------------------------------------------------------+
void CCheckBoxList::SetItemState(const uint item_index,const bool state)
  {
   uint array_size=::ArraySize(m_item_state);
//--- If there is no item in the list view, report
   if(array_size<1)
      ::Print(__FUNCTION__," > This method is to be called, if the list has at least one item!");
//--- Adjustment in case the range has been exceeded
   uint check_index=(item_index>=array_size)? array_size-1 : item_index;
//--- Store the value<
   m_item_state[check_index]=state;
//--- Moves the list along the scrollbar
   UpdateList();
  }
//+------------------------------------------------------------------+
//| Setting the value                                                |
//+------------------------------------------------------------------+
void CCheckBoxList::SetItemValue(const uint item_index,const string value)
  {
   uint array_size=::ArraySize(m_item_value);
//--- If there is no item in the list view, report
   if(array_size<1)
      ::Print(__FUNCTION__," > This method is to be called, if the list has at least one item!");
//--- Adjustment in case the range has been exceeded
   uint check_index=(item_index>=array_size)? array_size-1 : item_index;
//--- Store the value in the list view
   m_item_value[check_index]=value;
  }
//+------------------------------------------------------------------+
//| Get the state of the list checkbox                               |
//+------------------------------------------------------------------+
bool CCheckBoxList::GetItemState(const uint item_index)
  {
   uint array_size=::ArraySize(m_item_state);
//--- If there is no item in the list view, report
   if(array_size<1)
      ::Print(__FUNCTION__," > This method is to be called, if the list has at least one item!");
//--- Adjustment in case the range has been exceeded
   uint check_index=(item_index>=array_size)? array_size-1 : item_index;
//--- Store the value<
   return(m_item_state[check_index]);
  }
//+------------------------------------------------------------------+
//| Getting the value of the list item                               |
//+------------------------------------------------------------------+
string CCheckBoxList::GetItemValue(const uint item_index)
  {
   uint array_size=::ArraySize(m_item_state);
//--- If there is no item in the list view, report
   if(array_size<1)
      ::Print(__FUNCTION__," > This method is to be called, if the list has at least one item!");
//--- Adjustment in case the range has been exceeded
   uint check_index=(item_index>=array_size)? array_size-1 : item_index;
//--- Store the value<
   return(m_item_value[check_index]);
  }
//+------------------------------------------------------------------+
//| Sets the size of the list view                                   |
//+------------------------------------------------------------------+
void CCheckBoxList::ListSize(const int items_total)
  {
//--- No point to make a list view shorter than two items
   m_items_total=(items_total<1) ? 0 : items_total;
   ::ArrayResize(m_item_value,m_items_total);
   ::ArrayResize(m_item_state,m_items_total);
  }
//+------------------------------------------------------------------+
//| Sets the size of the visible part of the list view               |
//+------------------------------------------------------------------+
void CCheckBoxList::VisibleListSize(const int visible_items_total)
  {
//--- No point to make a list view shorter than two items
   m_visible_items_total=(visible_items_total<2) ? 2 : visible_items_total;
   ::ArrayResize(m_items,m_visible_items_total);
   ::ArrayResize(m_checks,m_visible_items_total);
   ::ArrayResize(m_labels,m_visible_items_total);
  }
//+------------------------------------------------------------------+
//| Rebuilding the list                                              |
//+------------------------------------------------------------------+
void CCheckBoxList::Rebuilding(const int items_total,const int visible_items_total)
  {
//--- Clearing the list
   Clear();
//--- Set the size of the list view and its visible part
   ListSize(items_total);
   VisibleListSize(visible_items_total);
//--- Adjust the list size
   int y_size=CalculationYSize();
   if(y_size!=CElementBase::YSize())
     {
      m_area.YSize(y_size);
      m_area.Y_Size(y_size);
      CElementBase::YSize(y_size);
     }
//--- Adjust the size of the scrollbar
   m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
   m_scrollv.ChangeYSize(y_size);
//--- Create the list
   CreateList();
//--- Display the scrollbar, if necessary
   if(m_items_total>m_visible_items_total)
     {
      if(CElementBase::IsVisible())
         m_scrollv.Show();
     }
  }
//+------------------------------------------------------------------+
//| Add item to the list                                             |
//+------------------------------------------------------------------+
void CCheckBoxList::AddItem(const string value="",const bool state=false)
  {
//--- Increase the array size by one element
   int array_size=ItemsTotal();
   m_items_total=array_size+1;
   ::ArrayResize(m_item_value,m_items_total);
   ::ArrayResize(m_item_state,m_items_total);
   m_item_value[array_size]=value;
   m_item_state[array_size]=state;
//--- Graphical object can be created only if the number of visible items is not exceeded
   if(m_items_total>m_visible_items_total)
     {
      //--- Adjust the size of the thumb and display the scrollbar
      m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
      if(CElementBase::IsVisible())
         m_scrollv.Show();
      //--- Leave, if the array has less than one element
      if(m_visible_items_total<1)
         return;
      //--- Calculating the width of the list view items
      int width=CElementBase::XSize()-m_scrollv.ScrollWidth()-1;
      if(width==m_items[0].XSize())
         return;
      //--- Set the new size to the list items
      for(int i=0; i<m_items_total && i<m_visible_items_total; i++)
        {
         m_items[i].XSize(width);
         m_items[i].X_Size(width);
        }
      //---
      return;
     }
//--- Create the item background
   int x=CElementBase::X()+1;
   int y=CalculationItemY(array_size);;
//--- Calculating the width of the list view items
   int width=CalculationItemsWidth();
//--- Creating the object
   CreateItem(array_size,x,y,width);
//--- Create the item checkbox
   x=CElementBase::X()+3;
   y=m_items[array_size].Y()+3;
   CreateCheck(array_size,x,y);
//--- Create the item text
   x=CElementBase::X()+20;
   y=m_items[array_size].Y()+3;
   CreateLabel(array_size,x,y);
  }
//+------------------------------------------------------------------+
//| Clears the list (deletes all items)                              |
//+------------------------------------------------------------------+
void CCheckBoxList::Clear(void)
  {
//--- Delete the item objects
   for(int r=0; r<m_visible_items_total; r++)
     {
      m_items[r].Delete();
      m_checks[r].Delete();
      m_labels[r].Delete();
     }
//--- Clear the array of pointers to objects
   CElementBase::FreeObjectsArray();
//--- Set the zero size to the list
   ListSize(0);
//--- Reset the scrollbar values
   m_scrollv.Hide();
   m_scrollv.MovingThumb(0);
   m_scrollv.ChangeThumbSize(m_items_total,m_visible_items_total);
//--- Add the list background to the array of pointers to objects of the control
   CElementBase::AddToArray(m_area);
  }
//+------------------------------------------------------------------+
//| Scrolling the list                                               |
//+------------------------------------------------------------------+
void CCheckBoxList::Scrolling(const int pos=WRONG_VALUE)
  {
//--- Leave, if the scrollbar is not required
   if(m_items_total<=m_visible_items_total)
      return;
//--- To determine the position of the thumb
   int index=0;
//--- Index of the last position
   int last_pos_index=m_items_total-m_visible_items_total;
//--- Adjustment in case the range has been exceeded
   if(pos<0)
      index=last_pos_index;
   else
      index=(pos>last_pos_index)? last_pos_index : pos;
//--- Move the scrollbar thumb
   m_scrollv.MovingThumb(index);
//--- Move the list
   UpdateList(index);
  }
//+------------------------------------------------------------------+
//| Resetting the color of the list view items                       |
//+------------------------------------------------------------------+
void CCheckBoxList::ResetItemsColor(void)
  {
//--- Get the current position of the scrollbar slider
   int v=m_scrollv.CurrentPos();
//--- Iterate over the visible part of the list view
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Increase the counter if the list view range has not been exceeded
      if(v>=0 && v<m_items_total)
         v++;
      //--- Setting the color (background, text)
      m_items[i].BackColor(m_item_color);
      m_items[i].Color(m_item_color);
     }
  }
//+------------------------------------------------------------------+
//| Changing color of the list view item when the cursor is hovering |
//+------------------------------------------------------------------+
void CCheckBoxList::ChangeItemsColor(void)
  {
//--- Leave, if the highlighting of the item when the cursor is hovering over it is disabled or the scrollbar is active
   if(!m_lights_hover || m_scrollv.ScrollState())
      return;
//--- Leave, if it is not a drop-down element and the form is blocked
   if(!CElementBase::IsDropdown() && m_wnd.IsLocked())
      return;
//--- If entered the list view again
   if(m_prev_item_index_focus==WRONG_VALUE)
     {
      //--- Check the focus on the current item
      CheckItemFocus();
     }
   else
     {
      //--- Check the focus on the current row
      int i=m_prev_item_index_focus;
      bool condition=m_mouse.X()>m_items[i].X() && m_mouse.X()<m_items[i].X2() && 
                     m_mouse.Y()>m_items[i].Y() && m_mouse.Y()<m_items[i].Y2();
      //--- If moved to another item
      if(!condition)
        {
         //--- Reset the color of the previous item
         m_items[i].BackColor(m_item_color);
         m_items[i].Color(m_item_color);
         m_prev_item_index_focus=WRONG_VALUE;
         //--- Check the focus on the current item
         CheckItemFocus();
        }
     }
  }
//+------------------------------------------------------------------+
//| Check the focus of list view items when the cursor is hovering   |
//+------------------------------------------------------------------+
void CCheckBoxList::CheckItemFocus(void)
  {
//--- Get the current position of the scrollbar slider
   int v=m_scrollv.CurrentPos();
//--- Identify over which item the cursor is over and highlight it
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- Increase the counter if the list view range has not been exceeded
      if(v>=0 && v<m_items_total)
         v++;
      //--- If the cursor is over this item, highlight it
      if(m_mouse.X()>m_items[i].X() && m_mouse.X()<m_items[i].X2() &&
         m_mouse.Y()>m_items[i].Y() && m_mouse.Y()<m_items[i].Y2())
        {
         m_items[i].BackColor(m_item_color_hover);
         m_items[i].Color(m_item_text_color_hover);
         //--- Remember the item
         m_prev_item_index_focus=i;
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| Update the list                                                  |
//+------------------------------------------------------------------+
void CCheckBoxList::UpdateList(const int pos=WRONG_VALUE)
  {
//--- Get the current position of the scrollbar slider
   int v=m_scrollv.CurrentPos();
//--- If the list must be moved to the specified position
   if(pos!=WRONG_VALUE)
     {
      v=pos;
      m_scrollv.MovingThumb(pos);
     }
//--- Iterate over the visible part of the list view
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- If inside the range of the list view
      if(v>=0 && v<m_items_total)
        {
         //--- Moving the text, the background color and the text color
         m_items[i].BackColor(m_item_color);
         m_checks[i].State(m_item_state[v]);
         m_labels[i].Description(m_item_value[v]);
         //--- Increase the counter
         v++;
        }
     }
  }
//+------------------------------------------------------------------+
//| Moving elements                                                  |
//+------------------------------------------------------------------+
void CCheckBoxList::Moving(const int x,const int y,const bool moving_mode=false)
  {
//--- Leave, if the control is hidden
   if(!CElementBase::IsVisible())
      return;
//--- If the management is delegated to the window, identify its location
   if(!moving_mode)
      if(m_wnd.ClampingAreaMouse()!=PRESSED_INSIDE_HEADER)
         return;
//--- Storing indents in the element fields
   CElementBase::X((m_anchor_right_window_side)? m_wnd.X2()-XGap() : x+XGap());
   CElementBase::Y((m_anchor_bottom_window_side)? m_wnd.Y2()-YGap() : y+YGap());
//--- Storing coordinates in the fields of the objects
   m_area.X((m_anchor_right_window_side)? m_wnd.X2()-m_area.XGap() : x+m_area.XGap());
   m_area.Y((m_anchor_bottom_window_side)? m_wnd.Y2()-m_area.YGap() : y+m_area.YGap());
//--- Updating coordinates of graphical objects   
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//---
   for(int r=0; r<m_visible_items_total; r++)
     {
      //--- Storing coordinates in the fields of the objects
      m_items[r].X((m_anchor_right_window_side)? m_wnd.X2()-m_items[r].XGap() : x+m_items[r].XGap());
      m_items[r].Y((m_anchor_bottom_window_side)? m_wnd.Y2()-m_items[r].YGap() : y+m_items[r].YGap());
      m_checks[r].X((m_anchor_right_window_side)? m_wnd.X2()-m_checks[r].XGap() : x+m_checks[r].XGap());
      m_checks[r].Y((m_anchor_bottom_window_side)? m_wnd.Y2()-m_checks[r].YGap() : y+m_checks[r].YGap());
      m_labels[r].X((m_anchor_right_window_side)? m_wnd.X2()-m_labels[r].XGap() : x+m_labels[r].XGap());
      m_labels[r].Y((m_anchor_bottom_window_side)? m_wnd.Y2()-m_labels[r].YGap() : y+m_labels[r].YGap());
      //--- Updating coordinates of graphical objects
      m_items[r].X_Distance(m_items[r].X());
      m_items[r].Y_Distance(m_items[r].Y());
      m_checks[r].X_Distance(m_checks[r].X());
      m_checks[r].Y_Distance(m_checks[r].Y());
      m_labels[r].X_Distance(m_labels[r].X());
      m_labels[r].Y_Distance(m_labels[r].Y());
     }
  }
//+------------------------------------------------------------------+
//| Show the list view                                               |
//+------------------------------------------------------------------+
void CCheckBoxList::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElementBase::IsVisible())
      return;
//--- Make all the objects visible
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Show the scrollbar
   m_scrollv.Show();
//--- Visible state
   CElementBase::IsVisible(true);
//--- Send a signal for zeroing priorities of the left mouse click
   if(CElementBase::IsDropdown())
      ::EventChartCustom(m_chart_id,ON_ZERO_PRIORITIES,m_id,0.0,"");
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Hide the list view                                               |
//+------------------------------------------------------------------+
void CCheckBoxList::Hide(void)
  {
   if(!m_wnd.IsMinimized())
      if(!CElementBase::IsDropdown())
         if(!CElementBase::IsVisible())
            return;
//--- Hide all objects
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Hide the scrollbar
   m_scrollv.Hide();
//--- Visible state
   CElementBase::IsVisible(false);
//--- Send a signal to restore the priorities of the left mouse click
   if(!m_wnd.IsMinimized() && CElementBase::IsVisible())
      ::EventChartCustom(m_chart_id,ON_SET_PRIORITIES,CElementBase::Id(),0.0,CElementBase::ClassName());
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CCheckBoxList::Reset(void)
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
void CCheckBoxList::Delete(void)
  {
//--- Removing objects
   m_area.Delete();
   for(int r=0; r<m_visible_items_total; r++)
     {
      m_items[r].Delete();
      m_checks[r].Delete();
      m_labels[r].Delete();
     }
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CCheckBoxList::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_scrollv.SetZorders();
   for(int i=0; i<m_visible_items_total; i++)
     {
      m_items[i].Z_Order(m_item_zorder);
      m_checks[i].Z_Order(m_area_zorder);
      m_labels[i].Z_Order(m_area_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CCheckBoxList::ResetZorders(void)
  {
   m_area.Z_Order(-1);
   m_scrollv.ResetZorders();
   for(int i=0; i<m_visible_items_total; i++)
     {
      m_items[i].Z_Order(-1);
      m_checks[i].Z_Order(-1);
      m_labels[i].Z_Order(-1);
     }
  }
//+------------------------------------------------------------------+
//| Reset the color                                                  |
//+------------------------------------------------------------------+
void CCheckBoxList::ResetColors(void)
  {
   ResetItemsColor();
   m_scrollv.ResetColors();
  }
//+------------------------------------------------------------------+
//| Handling the pressing on the list view item                      |
//+------------------------------------------------------------------+
bool CCheckBoxList::OnClickListItem(const string clicked_object)
  {
//--- Leave, if the list view is not in focus
   if(!CElementBase::MouseFocus())
      return(false);
//--- Leave, if the form is blocked and identifiers do not match
   if(m_wnd.IsLocked() && !CElement::CheckIdActivatedElement())
      return(false);
//--- Leave, if the scrollbar is active
   if(m_scrollv.ScrollState())
      return(false);
//--- Leave, if the clicking was not on the menu item
   if(::StringFind(clicked_object,CElementBase::ProgramName()+"_checkboxlist_item_",0)<0)
      return(false);
//--- Get the identifier and index from the object name
   int id=CElementBase::IdFromObjectName(clicked_object);
//--- Leave, if the identifier does not match
   if(id!=CElementBase::Id())
      return(false);
//--- Get the current position of the scrollbar slider
   int v=m_scrollv.CurrentPos();
//--- Search for the item index
   int index=WRONG_VALUE;
//--- Go over the visible part of the list view
   for(int i=0; i<m_visible_items_total; i++)
     {
      //--- If this list view item was selected
      if(m_items[i].Name()==clicked_object)
        {
         index=i;
         m_item_state[v]=!m_checks[i].State();
         m_checks[i].State(m_item_state[v]);
         m_prev_item_index_focus=WRONG_VALUE;
         break;
        }
      //--- If inside the range of the list view
      if(v>=0 && v<m_items_total)
         //--- Increase the counter
         v++;
     }
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElementBase::Id(),v,m_labels[index].Description());
   return(true);
  }
//+------------------------------------------------------------------+
//| Fast forward of the list view                                    |
//+------------------------------------------------------------------+
void CCheckBoxList::FastSwitching(void)
  {
//--- Leave, if there is no focus on the list view
   if(!CElementBase::MouseFocus())
      return;
//--- Return counter to initial value if the mouse button is released если кнопка мыши отжата
   if(!m_mouse.LeftButtonState())
      m_timer_counter=SPIN_DELAY_MSC;
//--- If the mouse button is pressed down
   else
     {
      //--- Increase the counter by the set step
      m_timer_counter+=TIMER_STEP_MSC;
      //--- Exit if below zero
      if(m_timer_counter<0)
         return;
      //--- If scrolling up
      if(m_scrollv.ScrollIncState())
         m_scrollv.OnClickScrollInc(m_scrollv.ScrollIncName());
      //--- If scrolling down
      else if(m_scrollv.ScrollDecState())
         m_scrollv.OnClickScrollDec(m_scrollv.ScrollDecName());
      //--- Moves the list
      UpdateList();
     }
  }
//+------------------------------------------------------------------+
//| Calculation of the Y coordinate of the item                      |
//+------------------------------------------------------------------+
int CCheckBoxList::CalculationItemY(const int item_index=0)
  {
   return((item_index>0)? m_items[item_index-1].Y2()-1 : CElementBase::Y()+1);
  }
//+------------------------------------------------------------------+
//| Calculating the width of items                                   |
//+------------------------------------------------------------------+
int CCheckBoxList::CalculationItemsWidth(void)
  {
   return((m_items_total>m_visible_items_total) ? CElementBase::XSize()-m_scrollv.ScrollWidth()-1 : CElementBase::XSize()-2);
  }
//+------------------------------------------------------------------+
//| Calculation of the list size along the Y axis                    |
//+------------------------------------------------------------------+
int CCheckBoxList::CalculationYSize(void)
  {
   return(m_item_y_size*m_visible_items_total-(m_visible_items_total-1)+2);
  }
//+------------------------------------------------------------------+
