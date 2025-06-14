//+------------------------------------------------------------------+
//|                                                  LabelsTable.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
#include "Scrolls.mqh"
//+------------------------------------------------------------------+
//| Class for creating a text label table                            |
//+------------------------------------------------------------------+
class CLabelsTable : public CElement
  {
private:
   //--- Objects for creating a table
   CRectLabel        m_area;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   //--- Array of objects for the visible part of the table
   struct LTLabels
     {
      CLabel            m_rows[];
     };
   LTLabels          m_columns[];
   //--- Array of table values and properties
   struct LTOptions
     {
      string            m_vrows[];
      color             m_colors[];
     };
   LTOptions         m_vcolumns[];
   //--- The number of columns and rows (total and of visible part) of the table
   int               m_rows_total;
   int               m_columns_total;
   int               m_visible_rows_total;
   int               m_visible_columns_total;
   //--- Row height
   int               m_row_y_size;
   //--- Table background color
   color             m_area_color;
   //--- Default color of table text
   color             m_text_color;
   //--- Distance between the anchor point of the first column and the left edge of the control
   int               m_x_offset;
   //--- Distance between the anchor points of the columns
   int               m_column_x_offset;
   //--- Fixation mode of the first row
   bool              m_fix_first_row;
   //--- Fixation mode of the first column
   bool              m_fix_first_column;
   //--- Priorities of the left mouse button press
   int               m_zorder;
   int               m_area_zorder;
   //--- Timer counter for fast forwarding the list view
   int               m_timer_counter;
   //---
public:
                     CLabelsTable(void);
                    ~CLabelsTable(void);
   //--- Methods for creating table
   bool              CreateLabelsTable(const long chart_id,const int subwin,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateArea(void);
   bool              CreateLabels(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   //---
public:
   //--- Returns pointers to the scrollbars
   CScrollV         *GetScrollVPointer(void)                      { return(::GetPointer(m_scrollv)); }
   CScrollH         *GetScrollHPointer(void)                      { return(::GetPointer(m_scrollh)); }
   //--- Returns the total number of (1) rows and (2) columns
   int               RowsTotal(void)                        const { return(m_rows_total);            }
   int               ColumnsTotal(void)                     const { return(m_columns_total);         }
   //--- Returns the number of (1) rows and (2) columns of the visible part of the table
   int               VisibleRowsTotal(void)                 const { return(m_visible_rows_total);    }
   int               VisibleColumnsTotal(void)              const { return(m_visible_columns_total); }
   //--- (1) Background color, (2) text color
   void              AreaColor(const color clr)                   { m_area_color=clr;                }
   void              TextColor(const color clr)                   { m_text_color=clr;                }
   //--- (1) Row height, (2) set the distance between the anchor point of the first column and the left edge of the table,
   //    (3) set the distance between anchor points of columns
   void              RowYSize(const int y_size)                   { m_row_y_size=y_size;             }
   void              XOffset(const int x_offset)                  { m_x_offset=x_offset;             }
   void              ColumnXOffset(const int x_offset)            { m_column_x_offset=x_offset;      }
   //--- (1) Get and (2) set the fixation mode of the first row
   bool              FixFirstRow(void)                      const { return(m_fix_first_row);         }
   void              FixFirstRow(const bool flag)                 { m_fix_first_row=flag;            }
   //--- (1) Get and (2) set the fixation mode of the first column
   bool              FixFirstColumn(void)                   const { return(m_fix_first_column);      }
   void              FixFirstColumn(const bool flag)              { m_fix_first_column=flag;         }

   //--- Set the (1) size of the table and (2) size of its visible part 
   void              TableSize(const int columns_total,const int rows_total);
   void              VisibleTableSize(const int visible_columns_total,const int visible_rows_total);
   //--- Set the value to the specified table cell
   void              SetValue(const int column_index,const int row_index,const string value);
   //--- Get the value from the specified table cell
   string            GetValue(const int column_index,const int row_index);
   //--- Change the text color in the specified table cell
   void              TextColor(const int column_index,const int row_index,const color clr);
   //--- Update table data with consideration of the recent changes
   void              UpdateTable(void);

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
   //--- Fast forward of the list view
   void              FastSwitching(void);

   //--- Change the width at the right edge of the window
   virtual void      ChangeWidthByRightWindowSide(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CLabelsTable::CLabelsTable(void) : m_fix_first_row(false),
                                   m_fix_first_column(false),
                                   m_row_y_size(18),
                                   m_x_offset(30),
                                   m_column_x_offset(60),
                                   m_area_color(clrWhiteSmoke),
                                   m_text_color(clrBlack),
                                   m_rows_total(2),
                                   m_columns_total(1),
                                   m_visible_rows_total(2),
                                   m_visible_columns_total(1)
  {
//--- Store the name of the element class in the base class
   CElementBase::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_zorder      =0;
   m_area_zorder =1;
//--- Set the size of the table and its visible part
   TableSize(m_columns_total,m_rows_total);
   VisibleTableSize(m_visible_columns_total,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CLabelsTable::~CLabelsTable(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CLabelsTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      //--- Move the list if the management of the slider is enabled
      if(m_scrollv.ScrollBarControl() || m_scrollh.ScrollBarControl())
         UpdateTable();
      //---
      return;
     }
//--- Handling the pressing on objects
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- If the pressing was on a button of the table scrollbars
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
         //--- Shift the table relative to the scrollbar
         UpdateTable();
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CLabelsTable::OnEventTimer(void)
  {
//--- If this is a drop-down element
   if(CElementBase::IsDropdown())
      FastSwitching();
//--- If this is not a drop-down element, take current availability of the form into consideration
   else
     {
      //--- Track the fast forward of the table only if the form is not blocked
      if(!m_wnd.IsLocked())
         FastSwitching();
     }
  }
//+------------------------------------------------------------------+
//| Create text label table                                          |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateLabelsTable(const long chart_id,const int subwin,const int x_gap,const int y_gap)
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
   m_x_size   =(m_x_size<1 || m_auto_xresize_mode)? m_wnd.X2()-m_x-m_auto_xresize_right_offset : m_x_size;
   m_y_size   =m_row_y_size*m_visible_rows_total-(m_visible_rows_total-1)+2;
//--- Margins from the edge
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
//--- Create the table
   if(!CreateArea())
      return(false);
   if(!CreateLabels())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateScrollH())
      return(false);
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the table background                                      |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateArea(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_labelstable_area_"+(string)CElementBase::Id();
//--- If there is a horizontal scrollbar, adjust the table size along the Y axis
   m_y_size=(m_columns_total>m_visible_columns_total) ? m_y_size+m_scrollh.ScrollWidth()-1 : m_y_size;
//--- Creating the object
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Setting up properties
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
//| Create an array of text labels                                   |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateLabels(void)
  {
//--- Coordinates and offset
   int x      =CElementBase::X();
   int y      =0;
   int offset =0;
//--- Columns
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- Calculation of the table offset
      offset=(c>0) ? m_column_x_offset : m_x_offset;
      //--- Calculation of the X coordinate
      x=x+offset;
      //--- Rows
      for(int r=0; r<m_visible_rows_total; r++)
        {
         //--- Forming the object name
         string name=CElementBase::ProgramName()+"_labelstable_label_"+(string)c+"_"+(string)r+"__"+(string)CElementBase::Id();
         //--- Calculation of the Y coordinate
         y=(r>0)? y+m_row_y_size-1 : CElementBase::Y()+10;
         //--- Creating the object
         if(!m_columns[c].m_rows[r].Create(m_chart_id,name,m_subwin,x,y))
            return(false);
         //--- Setting up properties
         m_columns[c].m_rows[r].Description(m_vcolumns[c].m_vrows[r]);
         m_columns[c].m_rows[r].Font(CElementBase::Font());
         m_columns[c].m_rows[r].FontSize(CElementBase::FontSize());
         m_columns[c].m_rows[r].Color(m_text_color);
         m_columns[c].m_rows[r].Corner(m_corner);
         m_columns[c].m_rows[r].Anchor(ANCHOR_CENTER);
         m_columns[c].m_rows[r].Selectable(false);
         m_columns[c].m_rows[r].Z_Order(m_zorder);
         m_columns[c].m_rows[r].Tooltip("\n");
         //--- Coordinates
         m_columns[c].m_rows[r].X(x);
         m_columns[c].m_rows[r].Y(y);
         //--- Margins from the edge of the form
         m_columns[c].m_rows[r].XGap(CElement::CalculateXGap(x));
         m_columns[c].m_rows[r].YGap(CElement::CalculateYGap(y));
         //--- Store the object pointer
         CElementBase::AddToArray(m_columns[c].m_rows[r]);
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a vertical scrollbar                                      |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateScrollV(void)
  {
//--- Store the form pointer
   m_scrollv.WindowPointer(m_wnd);
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X2()-m_scrollv.ScrollWidth());
   int y=CElement::CalculateYGap(CElementBase::Y());
//--- Set properties
   m_scrollv.Id(CElementBase::Id());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(CElementBase::YSize()-m_scrollv.ScrollWidth()+1);
   m_scrollv.AnchorRightWindowSide(m_anchor_right_window_side);
   m_scrollv.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Creating the scrollbar
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_rows_total,m_visible_rows_total))
      return(false);
//--- Hide, if it is not required now
   if(m_rows_total<=m_visible_rows_total)
      m_scrollv.Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a horizontal scrollbar                                    |
//+------------------------------------------------------------------+
bool CLabelsTable::CreateScrollH(void)
  {
//--- Store the form pointer
   m_scrollh.WindowPointer(m_wnd);
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X());
   int y=CElement::CalculateYGap(CElementBase::Y2()-m_scrollh.ScrollWidth());
//--- Set properties
   m_scrollh.Id(CElementBase::Id());
   m_scrollh.XSize(CElementBase::XSize()-m_scrollh.ScrollWidth()+1);
   m_scrollh.YSize(m_scrollh.ScrollWidth());
   m_scrollh.AnchorRightWindowSide(m_anchor_right_window_side);
   m_scrollh.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Creating the scrollbar
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_columns_total,m_visible_columns_total))
      return(false);
//--- Hide, if it is not required now
   if(m_columns_total<=m_visible_columns_total)
      m_scrollh.Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Set the size of the table                                        |
//+------------------------------------------------------------------+
void CLabelsTable::TableSize(const int columns_total,const int rows_total)
  {
//--- There must be at least one column
   m_columns_total=(columns_total<1) ? 1 : columns_total;
//--- There must be at least two rows
   m_rows_total=(rows_total<2) ? 2 : rows_total;
//--- Set the size of the columns array
   ::ArrayResize(m_vcolumns,m_columns_total);
//--- Set the size of the rows arrays
   for(int i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_vcolumns[i].m_vrows,m_rows_total);
      ::ArrayResize(m_vcolumns[i].m_colors,m_rows_total);
      //--- Initialize the array of text colors with the default value
      ::ArrayInitialize(m_vcolumns[i].m_colors,m_text_color);
     }
  }
//+------------------------------------------------------------------+
//| Set the size of the visible part of the table                    |
//+------------------------------------------------------------------+
void CLabelsTable::VisibleTableSize(const int visible_columns_total,const int visible_rows_total)
  {
//--- There must be at least one column
   m_visible_columns_total=(visible_columns_total<1) ? 1 : visible_columns_total;
//--- There must be at least two rows
   m_visible_rows_total=(visible_rows_total<2) ? 2 : visible_rows_total;
//--- Set the size of the columns array
   ::ArrayResize(m_columns,m_visible_columns_total);
//--- Set the size of the rows arrays
   for(int i=0; i<m_visible_columns_total; i++)
      ::ArrayResize(m_columns[i].m_rows,m_visible_rows_total);
  }
//+------------------------------------------------------------------+
//| Set the value at the specified indexes                           |
//+------------------------------------------------------------------+
void CLabelsTable::SetValue(const int column_index,const int row_index,const string value)
  {
//--- Checking for exceeding the column range
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Checking for exceeding the row range
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Set the value
   m_vcolumns[column_index].m_vrows[row_index]=value;
  }
//+------------------------------------------------------------------+
//| Return value at the specified index                              |
//+------------------------------------------------------------------+
string CLabelsTable::GetValue(const int column_index,const int row_index)
  {
//--- Checking for exceeding the column range
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return("");
//--- Checking for exceeding the row range
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return("");
//--- Return the value
   return(m_vcolumns[column_index].m_vrows[row_index]);
  }
//+------------------------------------------------------------------+
//| Change color at the specified indexes                            |
//+------------------------------------------------------------------+
void CLabelsTable::TextColor(const int column_index,const int row_index,const color clr)
  {
//--- Checking for exceeding the column range
   int csize=::ArraySize(m_vcolumns);
   if(csize<1 || column_index<0 || column_index>=csize)
      return;
//--- Checking for exceeding the row range
   int rsize=::ArraySize(m_vcolumns[column_index].m_vrows);
   if(rsize<1 || row_index<0 || row_index>=rsize)
      return;
//--- Set the color
   m_vcolumns[column_index].m_colors[row_index]=clr;
  }
//+------------------------------------------------------------------+
//| Update table data with consideration of the recent changes       |
//+------------------------------------------------------------------+
void CLabelsTable::UpdateTable(void)
  {
//--- Shift by one index, if the fixed header mode is enabled
   int t=(m_fix_first_row) ? 1 : 0;
   int l=(m_fix_first_column) ? 1 : 0;
//--- Get the current positions of sliders of the vertical and horizontal scrollbars
   int h=m_scrollh.CurrentPos()+l;
   int v=m_scrollv.CurrentPos()+t;
//--- Shift of the headers in the left column
   if(m_fix_first_column)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      //--- Rows
      for(int r=t; r<m_visible_rows_total; r++)
        {
         if(r>=t && r<m_rows_total)
            m_columns[0].m_rows[r].Description(m_vcolumns[0].m_vrows[v]);
         //---
         v++;
        }
     }
//--- Shift of the headers in the top row
   if(m_fix_first_row)
     {
      m_columns[0].m_rows[0].Description(m_vcolumns[0].m_vrows[0]);
      //--- Columns
      for(int c=l; c<m_visible_columns_total; c++)
        {
         if(h>=l && h<m_columns_total)
            m_columns[c].m_rows[0].Description(m_vcolumns[h].m_vrows[0]);
         //---
         h++;
        }
     }
//--- Get the current position of slider of the horizontal scrollbar
   h=m_scrollh.CurrentPos()+l;
//--- Columns
   for(int c=l; c<m_visible_columns_total; c++)
     {
      //--- Get the current position of slider of the vertical scrollbar
      v=m_scrollv.CurrentPos()+t;
      //--- Rows
      for(int r=t; r<m_visible_rows_total; r++)
        {
         //--- Shift of the table data
         if(v>=t && v<m_rows_total && h>=l && h<m_columns_total)
           {
            //--- Color adjustment
            m_columns[c].m_rows[r].Color(m_vcolumns[h].m_colors[v]);
            //--- Value adjustment
            m_columns[c].m_rows[r].Description(m_vcolumns[h].m_vrows[v]);
            v++;
           }
        }
      //---
      h++;
     }
  }
//+------------------------------------------------------------------+
//| Moving the element                                               |
//+------------------------------------------------------------------+
void CLabelsTable::Moving(const int x,const int y,const bool moving_mode=false)
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
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::X(x+XGap());
      //--- Storing coordinates in the fields of the objects
      m_area.X(x+m_area.XGap());
     }
//--- If the anchored to the bottom
   if(m_anchor_bottom_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(m_wnd.Y2()-YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(m_wnd.Y2()-m_area.YGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::Y(y+YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(y+m_area.YGap());
     }
//--- Updating coordinates of graphical objects
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
//--- Columns
   for(int c=0; c<m_visible_columns_total; c++)
     {
      //--- Rows
      for(int r=0; r<m_visible_rows_total; r++)
        {
         //--- Storing coordinates in the fields of the objects
         m_columns[c].m_rows[r].X((m_anchor_right_window_side)? m_wnd.X2()-m_columns[c].m_rows[r].XGap() : x+m_columns[c].m_rows[r].XGap());
         m_columns[c].m_rows[r].Y((m_anchor_bottom_window_side)? m_wnd.Y2()-m_columns[c].m_rows[r].YGap() : y+m_columns[c].m_rows[r].YGap());
         //--- Updating coordinates of graphical objects
         m_columns[c].m_rows[r].X_Distance(m_columns[c].m_rows[r].X());
         m_columns[c].m_rows[r].Y_Distance(m_columns[c].m_rows[r].Y());
        }
     }
  }
//+------------------------------------------------------------------+
//| Shows the element                                                |
//+------------------------------------------------------------------+
void CLabelsTable::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElementBase::IsVisible())
      return;
//--- Make all the objects visible
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_ALL_PERIODS);
//--- Show the scrollbars
   m_scrollv.Show();
   m_scrollh.Show();
//--- Visible state
   CElementBase::IsVisible(true);
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Hides the element                                                |
//+------------------------------------------------------------------+
void CLabelsTable::Hide(void)
  {
//--- Leave, if the element is already hidden
   if(!CElementBase::IsVisible())
      return;
//--- Hide all objects
   for(int i=0; i<CElementBase::ObjectsElementTotal(); i++)
      CElementBase::Object(i).Timeframes(OBJ_NO_PERIODS);
//--- Hide the scrollbars
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- Visible state
   CElementBase::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CLabelsTable::Reset(void)
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
void CLabelsTable::Delete(void)
  {
//--- Delete graphical objects
   m_area.Delete();
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Delete();
      //---
      ::ArrayFree(m_columns[c].m_rows);
     }
//--- Emptying the control arrays
   for(int c=0; c<m_columns_total; c++)
     {
      ::ArrayFree(m_vcolumns[c].m_vrows);
      ::ArrayFree(m_vcolumns[c].m_colors);
     }
//---
   ::ArrayFree(m_columns);
   ::ArrayFree(m_vcolumns);
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::IsVisible(true);
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CLabelsTable::SetZorders(void)
  {
   m_area.Z_Order(m_area_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(m_zorder);
     }
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CLabelsTable::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_scrollv.ResetZorders();
   m_scrollh.ResetZorders();
//---
   for(int c=0; c<m_visible_columns_total; c++)
     {
      for(int r=0; r<m_visible_rows_total; r++)
         m_columns[c].m_rows[r].Z_Order(0);
     }
  }
//+------------------------------------------------------------------+
//| Fast forward                                                     |
//+------------------------------------------------------------------+
void CLabelsTable::FastSwitching(void)
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
      //--- If scrolling left
      else if(m_scrollh.ScrollIncState())
         m_scrollh.OnClickScrollInc(m_scrollh.ScrollIncName());
      //--- If scrolling right
      else if(m_scrollh.ScrollDecState())
         m_scrollh.OnClickScrollDec(m_scrollh.ScrollDecName());
      //--- Moves the list
      UpdateTable();
     }
  }
//+------------------------------------------------------------------+
//| Change the width at the right edge of the form                   |
//+------------------------------------------------------------------+
void CLabelsTable::ChangeWidthByRightWindowSide(void)
  {
//--- Leave, if anchoring mode to the right side of the window is enabled
   if(m_anchor_right_window_side)
      return;
//--- Coordinates
   int x=0;
//--- Sizes
   int x_size=0;
//--- Calculate and set the new size to the table background
   x_size=m_wnd.X2()-m_area.X()-m_auto_xresize_right_offset;
   CElementBase::XSize(x_size);
   m_area.XSize(x_size);
   m_area.X_Size(x_size);
//--- Calculate and set the new coordinate for the vertical scrollbar
   x=m_area.X2()-m_scrollv.ScrollWidth();
   m_scrollv.XDistance(x);
//--- Calculate and change the width of the horizontal scrollbar
   x_size=CElementBase::XSize()-m_scrollh.ScrollWidth()+1;
   m_scrollh.ChangeXSize(x_size);
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
