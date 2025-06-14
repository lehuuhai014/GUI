//+------------------------------------------------------------------+
//|                                                  CanvasTable.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
#include "Scrolls.mqh"
#include "Pointer.mqh"
//--- Resources
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp"
//+------------------------------------------------------------------+
//| Class for creating a rendered table                              |
//+------------------------------------------------------------------+
input int inpFontSize = 11;//Font size

class CCanvasTable : public CElement
  {
private:
   //--- Objects for creating a table
   
   CRectLabel        m_area;
   CRectCanvas       m_table;
   CRectCanvas       m_headers;
   CScrollV          m_scrollv;
   CScrollH          m_scrollh;
   CPointer          m_column_resize;
   //--- Image properties
   struct CTImage
     {
      uint              m_image_data[]; // Array of the image pixels
      uint              m_image_width;  // Image width
      uint              m_image_height; // Image height
      string            m_bmp_path;     // Path to the image file
     };
   //--- Properties of the table cells
   struct CTCell
     {
      ENUM_TYPE_CELL    m_type;           // Cell type
      CTImage           m_images[];       // Array of icons
      int               m_selected_image; // Index of the selected (displayed) icon
      string            m_full_text;      // Full text
      string            m_short_text;     // Shortened text
      color             m_text_color;     // Text color
      uint              m_digits;         // Number of decimal places
     };
   //--- Array of rows and properties of the table columns
   struct CTOptions
     {
      int               m_x;              // X coordinate of the left edge of the column
      int               m_x2;             // X coordinate of the right edge of the column
      int               m_width;          // Column width
      ENUM_DATATYPE     m_type;           // Type of data in the cell
      ENUM_ALIGN_MODE   m_text_align;     // Text alignment mode in the column cells
      int               m_text_x_offset;  // Text offset
      int               m_image_x_offset; // Image offset from the X-edge of the cell
      int               m_image_y_offset; // Image offset from the Y-edge of the cell
      string            m_header_text;    // Column header text
      CTCell            m_rows[];         // Array of the table rows
     };
   CTOptions         m_columns[];
   //--- Array of the table row properties
   struct CTRowOptions
     {
      int               m_y;  // Y coordinate of the top edge of the row
      int               m_y2; // Y coordinate of the bottom edge of the row
     };
   CTRowOptions      m_rows[];
   //--- The number of rows and columns
   uint              m_rows_total;
   uint              m_columns_total;
   //--- Total size and size of the visible part of the table
   int               m_table_x_size;
   int               m_table_y_size;
   int               m_table_visible_x_size;
   int               m_table_visible_y_size;
   //--- The minimum width of the columns
   int               m_min_column_width;
   //--- Table border color
   color             m_border_color;
   //--- Grid color
   color             m_grid_color;
   //--- Display mode of the table headers
   bool              m_show_headers;
   //--- Size (height) of the headers
   int               m_header_y_size;
   //--- Color of the headers (background) in different states
   color             m_headers_color;
   color             m_headers_color_hover;
   color             m_headers_color_pressed;
   //--- Header text color
   color             m_headers_text_color;
   //--- Icons for the sign of sorted data
   CTImage           m_sort_arrows[2];
   //--- Offsets for the sign icon of sorted data
   int               m_sort_arrow_x_gap;
   int               m_sort_arrow_y_gap;
   //--- Size (height) of cells
   int               m_cell_y_size;
   //--- Color of cells in different states
   color             m_cell_color;
   color             m_cell_color_hover;
   //--- Text color
   color             m_cell_text_color;
   //--- Color of (1) the background and (2) selected row text
   color             m_selected_row_color;
   color             m_selected_row_text_color;
   //--- (1) Index and (2) text of the selected row
   int               m_selected_item;
   string            m_selected_item_text;
   //--- Index of the previous selected row
   int               m_prev_selected_item;
   //--- Offsets for text from the cell edges
   int               m_text_x_offset;
   int               m_text_y_offset;
   //--- Icon offsets from the cell edges
   int               m_image_x_offset;
   int               m_image_y_offset;
   //--- Offset from the borders of separation lines to display the mouse pointer in the mode of changing the column width
   int               m_sep_x_offset;
   //--- Mode of highlighting rows when hovered
   bool              m_lights_hover;
   //--- Mode of sorting data according to columns
   bool              m_is_sort_mode;
   //--- Index of the sorted column (WRONG_VALUE – table is not sorted)
   int               m_is_sorted_column_index;
   //--- Last sorting direction
   _ENUM_SORT_MODE    m_last_sort_direction;
   //--- Selectable row mode
   bool              m_selectable_row;
   //--- No deselection of row when clicked again
   bool              m_is_without_deselect;
   //--- Mode of formatting in Zebra style
   color             m_is_zebra_format_rows;
   //--- Priorities of the left mouse button press
   int               m_zorder;
   int               m_cell_zorder;
   //--- State of the left mouse button (pressed down/released)
   bool              m_mouse_state;
   //--- Timer counter for fast forwarding the list view
   int               m_timer_counter;
   //--- To determine the row focus
   int               m_item_index_focus;
   //--- To determine the moment of mouse cursor transition from one row to another
   int               m_prev_item_index_focus;
   //--- To determine the moment of mouse cursor transition from one header to another
   int               m_prev_header_index_focus;
   //--- Mode of changing the column widths
   bool              m_column_resize_mode;
   //--- The state of dragging the header border to change the column width
   int               m_column_resize_control;
   //--- For determining the indexes of the visible part of the table
   uint              m_visible_table_from_index;
   uint              m_visible_table_to_index;
   //---
public:
                     CCanvasTable(void);
                    ~CCanvasTable(void);
   //--- Methods for creating table
   bool              CreateTable(const long chart_id,const int subwin,const int x_gap,const int y_gap);
   //---
private:
   bool              CreateArea(void);
   bool              CreateHeaders(void);
   bool              CreateTable(void);
   bool              CreateScrollV(void);
   bool              CreateScrollH(void);
   bool              CreateColumnResizePointer(void);
   //---
public:
   //--- Returns pointers to the scrollbars
   CScrollV         *GetScrollVPointer(void)                 { return(::GetPointer(m_scrollv));  }
   CScrollH         *GetScrollHPointer(void)                 { return(::GetPointer(m_scrollh));  }
   //--- Color of the (1) background, (2) border, (3) grid and (4) text of the table
   void              BorderColor(const color clr)            { m_border_color=clr;               }
   void              GridColor(const color clr)              { m_grid_color=clr;                 }
   void              TextColor(const color clr)              { m_cell_text_color=clr;            }
   //--- Color of cells in different states
   void              CellColor(const color clr)              { m_cell_color=clr;                 }
   void              CellColorHover(const color clr)         { m_cell_color_hover=clr;           }
   //--- (1) Headers display mode, height of the (2) headers and (3) cells
   void              ShowHeaders(const bool flag)            { m_show_headers=flag;              }
   void              HeaderYSize(const int y_size)           { m_header_y_size=y_size;           }
   void              CellYSize(const int y_size)             { m_cell_y_size=y_size;             }
   //--- (1) Background and (2) text color of the headers
   void              HeadersColor(const color clr)           { m_headers_color=clr;              }
   void              HeadersColorHover(const color clr)      { m_headers_color_hover=clr;        }
   void              HeadersColorPressed(const color clr)    { m_headers_color_pressed=clr;      }
   void              HeadersTextColor(const color clr)       { m_headers_text_color=clr;         }
   //--- Offsets for the sign of sorted table
   void              SortArrowXGap(const int x_gap)          { m_sort_arrow_x_gap=x_gap;         }
   void              SortArrowYGap(const int y_gap)          { m_sort_arrow_y_gap=y_gap;         }
   //--- Setting the icons for the sign of sorted data
   void              SortArrowFileAscend(const string path)  { m_sort_arrows[0].m_bmp_path=path; }
   void              SortArrowFileDescend(const string path) { m_sort_arrows[1].m_bmp_path=path; }
   //--- Returns the total number of (1) rows and (2) columns
   uint              RowsTotal(void)                   const { return(m_rows_total);             }
   uint              ColumnsTotal(void)                const { return(m_columns_total);          }
   //--- Offsets of the text from the cell edges
   void              TextXOffset(const int x_offset)         { m_text_x_offset=x_offset;         }
   void              TextYOffset(const int y_offset)         { m_text_y_offset=y_offset;         }
   //--- Icon offsets from the cell edges
   void              ImageXOffset(const int x_offset)        { m_image_x_offset=x_offset;        }
   void              ImageYOffset(const int y_offset)        { m_image_y_offset=y_offset;        }
   //--- Returns the (1) index and (2) text of the selected row in the table
   int               SelectedItem(void)                const { return(m_selected_item);          }
   string            SelectedItemText(void)            const { return(m_selected_item_text);     }
   //--- (1) Row highlighting when hovered, (2) sorting data modes
   void              LightsHover(const bool flag)            { m_lights_hover=flag;              }
   void              IsSortMode(const bool flag)             { m_is_sort_mode=flag;              }
   //--- Modes of (1) row selection, (2) no deselection of row when clicked again
   void              SelectableRow(const bool flag)          { m_selectable_row=flag;            }
   void              IsWithoutDeselect(const bool flag)      { m_is_without_deselect=flag;       }
   //--- (1) Formatting of rows in Zebra style, (2) mode of changing the column widths
   void              IsZebraFormatRows(const color clr)      { m_is_zebra_format_rows=clr;       }
   void              ColumnResizeMode(const bool flag)       { m_column_resize_mode=flag;        }

   //--- Returns the total number of icons in the specified cell
   int               ImagesTotal(const uint column_index,const uint row_index);
   //--- The minimum width of the columns
   void              MinColumnWidth(const int width);
   //--- Set the main size of the table
   void              TableSize(const int columns_total,const int rows_total);

   //--- Rebuilding the table
   void              Rebuilding(const int columns_total,const int rows_total,const bool redraw=false);
   //--- Adds a column to the table at the specified index
   void              AddColumn(const int column_index,const bool redraw=false);
   //--- Removes a column from the table at the specified index
   void              DeleteColumn(const int column_index,const bool redraw=false);
   //--- Adds a row to the table at the specified index
   void              AddRow(const int row_index,const bool redraw=false);
   //--- Removes a row from the table at the specified index
   void              DeleteRow(const int row_index,const bool redraw=false);
   //--- Clears the table. Only one column and one row are left.
   void              Clear(const bool redraw=false);

   //--- Setting the text to the specified header
   void              SetHeaderText(const uint column_index,const string value);
   //--- Setting the (1) text alignment mode, (2) text offsets within a cell along the X axis and (3) width for each column
   void              TextAlign(const ENUM_ALIGN_MODE &array[]);
   void              TextXOffset(const int &array[]);
   void              ColumnsWidth(const int &array[]);
   //--- Offset of the images along the X and Y axes
   void              ImageXOffset(const int &array[]);
   void              ImageYOffset(const int &array[]);
   //--- Setting/getting the data type
   void              DataType(const uint column_index,const ENUM_DATATYPE type);
   ENUM_DATATYPE     DataType(const uint column_index);
   //--- Setting/getting the cell type
   void              CellType(const uint column_index,const uint row_index,const ENUM_TYPE_CELL type);
   ENUM_TYPE_CELL    CellType(const uint column_index,const uint row_index);
   //--- Set icons to the specified cell
   void              SetImages(const uint column_index,const uint row_index,const string &bmp_file_path[]);
   //--- Changes/obtains the icon (index) in the specified cell
   void              ChangeImage(const uint column_index,const uint row_index,const uint image_index,const bool redraw=false);
   int               SelectedImageIndex(const uint column_index,const uint row_index);
   //--- Set the text color to the specified table cell
   void              TextColor(const uint column_index,const uint row_index,const color clr,const bool redraw=false);
   //--- Set/get the value in the specified table cell
   void              SetValue(const uint column_index,const uint row_index,const string value="",const uint digits=0,const bool redraw=false);
   string            GetValue(const uint column_index,const uint row_index);

   //--- Table scrolling: (1) vertical and (2) horizontal
   void              VerticalScrolling(const int pos=WRONG_VALUE);
   void              HorizontalScrolling(const int pos=WRONG_VALUE);
   //--- Shift the table relative to the positions of scrollbars
   void              ShiftTable(void);
   //--- Sort the data according to the specified column
   void              SortData(const uint column_index=0);
   //--- Updating the table
   void              UpdateTable(const bool redraw=false);
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
   //--- Handling clicking on a header
   bool              OnClickHeaders(const string clicked_object);
   //--- Handling clicking on the table
   bool              OnClickTable(const string clicked_object);
   //--- Handling double clicking on the table
   bool              OnDoubleClickTable(const string clicked_object);

   //--- Returns the index of the clicked row
   int               PressedRowIndex(void);
   //--- Returns the index of the clicked cell column
   int               PressedCellColumnIndex(void);
   //--- Check if the cell control was activated when clicked
   bool              CheckCellElement(const int column_index,const int row_index,const bool double_click=false);
   //--- Check if the button in the cell was clicked
   bool              CheckPressedButton(const int column_index,const int row_index,const bool double_click=false);
   //--- Check if the checkbox in the cell was clicked
   bool              CheckPressedCheckBox(const int column_index,const int row_index,const bool double_click=false);

   //--- Quicksort method
   void              QuickSort(uint beg,uint end,uint column,const _ENUM_SORT_MODE mode=SORT_ASCEND);
   //--- Checking the sorting conditions
   bool              CheckSortCondition(uint column_index,uint row_index,const string check_value,const bool direction);
   //--- Swap the values in the specified cells
   void              Swap(uint r1,uint r2);

   //--- Calculate the table size
   void              CalculateTableSize(void);
   //--- Change the main size of the table
   void              ChangeMainSize(const int x_size,const int y_size);
   //--- Resize the table
   void              ChangeTableSize(void);
   //--- Resize the scrollbars
   void              ChangeScrollsSize(void);
   //--- Determining the indexes of the visible part of the table
   void              VisibleTableIndexes(void);

   //--- Returns the text
   string            Text(const int column_index,const int row_index);
   //--- Returns the X coordinate of the text in the specified column
   int               TextX(const int column_index,const bool headers=false);
   //--- Returns the text alignment mode in the specified column
   uint              TextAlign(const int column_index,const uint anchor);
   //--- Returns the color of the cell text
   uint              TextColor(const int column_index,const int row_index);

   //--- Returns the current header background color
   uint              HeaderColorCurrent(const bool is_header_focus);
   //--- Returns the current row background color
   uint              RowColorCurrent(const int row_index,const bool is_row_focus);

   //--- Draws the table with consideration of the recent changes
   void              DrawTable(const bool only_visible=false);

   //--- Draws the table headers
   void              DrawTableHeaders(void);
   //--- Draws the headers
   void              DrawHeaders(void);
   //--- Draws the grid of the table headers
   void              DrawHeadersGrid(void);
   //--- Draws the sign of the possibility of sorting the table
   void              DrawSignSortedData(void);
   //--- Draws the text of the table headers
   void              DrawHeadersText(void);

   //--- Draws the background of the table rows
   void              DrawRows(void);
   //--- Draws a selected row
   void              DrawSelectedRow(void);
   //--- Draw grid
   void              DrawGrid(void);
   //--- Draw all icons of the table
   void              DrawImages(void);
   //--- Draw an icon in the specified cell
   void              DrawImage(const int column_index,const int row_index);
   //--- Draw text
   void              DrawText(void);

   //--- Redraws the specified cell of the table
   void              RedrawCell(const int column_index,const int row_index);
   //--- Redraws the specified table row according to the specified mode
   void              RedrawRow(const bool is_selected_row=false);

   //--- Checking the focus on the headers
   void              CheckHeaderFocus(void);
   //--- Checking the focus on the table rows
   int               CheckRowFocus(void);
   //--- Checking the focus on borders of headers to change their widths
   void              CheckColumnResizeFocus(void);
   //--- Changes the width of the dragged column
   void              ChangeColumnWidth(void);

   //--- Checks the size of the passed array and returns the adjusted value
   template<typename T>
   int               CheckArraySize(const T &array[]);
   //--- Checking for exceeding the range of columns
   bool              CheckOutOfColumnRange(const uint column_index);
   //--- Checking for exceeding the range of columns and rows
   bool              CheckOutOfRange(const uint column_index,const uint row_index);
   //--- Recalculate with consideration of the recent changes and resize the table
   void              RecalculateAndResizeTable(const bool redraw=false);

   //--- Initialize the specified column with the default values
   void              ColumnInitialize(const uint column_index);
   //--- Initialize the specified cell with the default values
   void              CellInitialize(const uint column_index,const uint row_index);

   //--- Makes a copy of the specified column (source) to a new location (dest.)
   void              ColumnCopy(const uint destination,const uint source);
   //--- Makes a copy of the specified cell (source) to a new location (dest.)
   void              CellCopy(const uint column_dest,const uint row_dest,const uint column_source,const uint row_source);
   //--- Copies the image data from one array to another
   void              ImageCopy(CTImage &destination[],CTImage &source[],const int index);

   //--- Changes the color of the table objects
   void              ChangeObjectsColor(void);
   //--- Change the header color when hovered by mouse cursor
   void              ChangeHeadersColor(void);
   //--- Changing the row color when hovered
   void              ChangeRowsColor(void);

   //--- Returns the text adjusted to the column width
   string            CorrectingText(const int column_index,const int row_index,const bool headers=false);

   //--- Fast forward of the table
   void              FastSwitching(void);

   //--- Change the width at the right edge of the window
   virtual void      ChangeWidthByRightWindowSide(void);
   //--- Change the height at the bottom edge of the window
   virtual void      ChangeHeightByBottomWindowSide(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CCanvasTable::CCanvasTable(void) : m_rows_total(1),
                                   m_columns_total(1),
                                   m_show_headers(false),
                                   m_header_y_size(20),
                                   m_cell_y_size(20),
                                   m_min_column_width(30),
                                   m_border_color(C'240,240,240'),
                                   m_grid_color(clrLightGray),
                                   m_headers_color(clrWhiteSmoke),
                                   m_headers_color_hover(C'217,235,249'),
                                   m_headers_color_pressed(C'188,220,244'),
                                   m_headers_text_color(clrBlack),
                                   m_is_sort_mode(false),
                                   m_last_sort_direction(SORT_ASCEND),
                                   m_is_sorted_column_index(WRONG_VALUE),
                                   m_sort_arrow_x_gap(20),
                                   m_sort_arrow_y_gap(6),
                                   m_cell_color(clrWhite),
                                   m_cell_color_hover(C'240,240,240'),
                                   m_cell_text_color(clrBlack),
                                   m_prev_selected_item(WRONG_VALUE),
                                   m_selected_item(WRONG_VALUE),
                                   m_selected_item_text(""),
                                   m_text_x_offset(5),
                                   m_text_y_offset(4),
                                   m_image_x_offset(3),
                                   m_image_y_offset(2),
                                   m_sep_x_offset(5),
                                   m_lights_hover(false),
                                   m_selectable_row(false),
                                   m_is_without_deselect(false),
                                   m_column_resize_mode(false),
                                   m_column_resize_control(WRONG_VALUE),
                                   m_item_index_focus(WRONG_VALUE),
                                   m_prev_item_index_focus(WRONG_VALUE),
                                   m_prev_header_index_focus(WRONG_VALUE),
                                   m_selected_row_color(C'51,153,255'),
                                   m_selected_row_text_color(clrWhite),
                                   m_is_zebra_format_rows(clrNONE),
                                   m_visible_table_from_index(WRONG_VALUE),
                                   m_visible_table_to_index(WRONG_VALUE)
  {
//--- Store the name of the element class in the base class
   CElementBase::ClassName(CLASS_NAME);
//--- Set priorities of the left mouse button click
   m_zorder      =1;
   m_cell_zorder =2;
//--- Set the table size
   TableSize(m_columns_total,m_rows_total);
//--- Initializing the structure of the sorting sign
   m_sort_arrows[0].m_bmp_path="";
   m_sort_arrows[1].m_bmp_path="";
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CCanvasTable::~CCanvasTable(void)
  {
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CCanvasTable::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
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
      m_headers.MouseFocus(m_mouse.X()>m_headers.X() && m_mouse.X()<m_headers.X2() && 
                           m_mouse.Y()>m_headers.Y() && m_mouse.Y()<m_headers.Y2());
      m_table.MouseFocus(m_mouse.X()>m_table.X() && m_mouse.X()<m_table.X2() && 
                         m_mouse.Y()>m_table.Y() && m_mouse.Y()<m_table.Y2());
      //--- If the scrollbar is active
      if(m_scrollv.ScrollBarControl() || m_scrollh.ScrollBarControl())
        {
         ShiftTable();
         return;
        }
      //--- Changing the object colors
      ChangeObjectsColor();
      //--- Change the width of the dragged column
      ChangeColumnWidth();
      return;
     }
//--- Handling the pressing on objects
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Clicking the header
      if(OnClickHeaders(sparam))
         return;
      //--- Clicking the table
      if(OnClickTable(sparam))
         return;
      //--- If the scrollbar button was pressed
      if(m_scrollv.OnClickScrollInc(sparam) || m_scrollv.OnClickScrollDec(sparam) ||
         m_scrollh.OnClickScrollInc(sparam) || m_scrollh.OnClickScrollDec(sparam))
        {
         //--- Shift the table
         ShiftTable();
        }
      //---
      return;
     }
//--- Change in the state of the left mouse button
   if(id==CHARTEVENT_CUSTOM+ON_CHANGE_MOUSE_LEFT_BUTTON)
     {
      //--- Leave, if the headers are disabled
      if(!m_show_headers)
         return;
      //--- If the left mouse button is released
      if(!m_mouse.LeftButtonState())
        {
         //--- Reset the width changing mode
         m_column_resize_control=WRONG_VALUE;
         //--- Redraw the table
         DrawTable();
         //--- Hide the cursor
         m_column_resize.Hide();
         //--- Adjust the scrollbar with consideration of the recent changes
         HorizontalScrolling(m_scrollh.CurrentPos());
        }
      //--- Reset the index of the last focus on a header
      m_prev_header_index_focus=WRONG_VALUE;
      //--- Changing the object colors
      ChangeObjectsColor();
      return;
     }
//--- Handling the left mouse button double click
   if(id==CHARTEVENT_CUSTOM+ON_DOUBLE_CLICK)
     {
      //--- Clicking the table
      if(OnDoubleClickTable(sparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CCanvasTable::OnEventTimer(void)
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
//| Create a rendered table                                          |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateTable(const long chart_id,const int subwin,const int x_gap,const int y_gap)
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
   m_x_size   =(m_x_size<1 || m_auto_xresize_mode)? (m_anchor_right_window_side)? m_wnd.X2()-m_x-m_auto_xresize_right_offset : m_wnd.X2()-m_x-m_auto_xresize_right_offset : m_x_size;
   m_y_size   =(m_y_size<1 || m_auto_yresize_mode)? (m_anchor_bottom_window_side)? m_wnd.Y2()-m_y-m_auto_yresize_bottom_offset : m_wnd.Y2()-m_y-m_auto_yresize_bottom_offset : m_y_size;
//--- Margins from the edge
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
//--- Calculate the tale sizes
   CalculateTableSize();
//--- Create the table
   if(!CreateArea())
      return(false);
   if(!CreateTable())
      return(false);
   if(!CreateHeaders())
      return(false);
   if(!CreateScrollV())
      return(false);
   if(!CreateScrollH())
      return(false);
   if(!CreateColumnResizePointer())
      return(false);
//--- Resize the table
   ChangeTableSize();
//--- Draw the table
   DrawTable();
//--- Hide the element if the window is a dialog one or is minimized
   if(m_wnd.WindowType()==W_DIALOG || m_wnd.IsMinimized())
      Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the table background                                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateArea(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_table_area_"+(string)CElementBase::Id();
//--- Creating the object
   if(!m_area.Create(m_chart_id,name,m_subwin,m_x,m_y,m_x_size,m_y_size))
      return(false);
//--- Setting up properties
   m_area.BackColor(m_cell_color);
   m_area.Color(m_border_color);
   m_area.BorderType(BORDER_FLAT);
   m_area.Corner(m_corner);
   m_area.Selectable(false);
   m_area.Z_Order(m_zorder);
   m_area.Tooltip("\n");
//--- Store coordinates
   m_area.X(m_x);
   m_area.Y(m_y);
//--- Store the size
   m_area.XSize(m_x_size);
   m_area.YSize(m_y_size);
//--- Margins from the edge
   m_area.XGap(CElement::CalculateXGap(m_x));
   m_area.YGap(CElement::CalculateYGap(m_y));
//--- Store the object pointer
   CElementBase::AddToArray(m_area);
   return(true);
  }
//+------------------------------------------------------------------+
//| Create a table                                                   |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateTable(void)
  {
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_table_"+(string)CElementBase::Id();
//--- Coordinates
   int x =m_x+1;
   int y =m_y+((m_show_headers)? m_header_y_size : 1);
//--- Creating the object
   ::ResetLastError();
   if(!m_table.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,m_table_x_size,m_table_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Failed to create a canvas for drawing the table: ",::GetLastError());
      return(false);
     }
//--- Attach to the chart
   if(!m_table.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Set properties
   m_table.Tooltip("\n");
//--- Coordinates
   m_table.X(x);
   m_table.Y(y);
//--- Store the size
   m_table.XSize(m_table_visible_x_size);
   m_table.YSize(m_table_visible_y_size);
//--- Margins from the edge of the panel
   m_table.XGap(CElement::CalculateXGap(x));
   m_table.YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_table);
//--- Set the size of the visible area
   m_table.SetInteger(OBJPROP_XSIZE,m_table_visible_x_size);
   m_table.SetInteger(OBJPROP_YSIZE,m_table_visible_y_size);
//--- Set the frame offset within the image along the X and Y axes
   m_table.SetInteger(OBJPROP_XOFFSET,0);
   m_table.SetInteger(OBJPROP_YOFFSET,0);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the table headers                                        |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateHeaders(void)
  {
//--- Leave, if the headers are disabled
   if(!m_show_headers)
      return(true);
//--- Forming the object name
   string name=CElementBase::ProgramName()+"_table_headers_"+(string)CElementBase::Id();
//--- Coordinates
   int x =m_x+1;
   int y =m_y+1;
//--- Define the icons as a sign of the possibility of sorting the table
   if(m_sort_arrows[0].m_bmp_path=="")
      m_sort_arrows[0].m_bmp_path="::Images\\EasyAndFastGUI\\Controls\\SpinInc.bmp";
   if(m_sort_arrows[1].m_bmp_path=="")
      m_sort_arrows[1].m_bmp_path="::Images\\EasyAndFastGUI\\Controls\\SpinDec.bmp";
//---
   for(int i=0; i<2; i++)
     {
      ::ResetLastError();
      if(!::ResourceReadImage(m_sort_arrows[i].m_bmp_path,m_sort_arrows[i].m_image_data,
         m_sort_arrows[i].m_image_width,m_sort_arrows[i].m_image_height))
        {
         ::Print(__FUNCTION__," > error: ",::GetLastError());
        }
     }
//--- Creating the object
   ::ResetLastError();
   if(!m_headers.CreateBitmapLabel(m_chart_id,m_subwin,name,x,y,m_table_x_size,m_header_y_size,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      ::Print(__FUNCTION__," > Failed to create a canvas for drawing the table headers: ",::GetLastError());
      return(false);
     }
//--- Attach to the chart
   if(!m_headers.Attach(m_chart_id,name,m_subwin,1))
      return(false);
//--- Set properties
   m_headers.Tooltip("\n");
//--- Coordinates
   m_headers.X(x);
   m_headers.Y(y);
//--- Store the size
   m_headers.XSize(m_table_visible_x_size);
   m_headers.YSize(m_header_y_size);
//--- Margins from the edge of the panel
   m_headers.XGap(CElement::CalculateXGap(x));
   m_headers.YGap(CElement::CalculateYGap(y));
//--- Store the object pointer
   CElementBase::AddToArray(m_headers);
//--- Set the size of the visible area
   m_headers.SetInteger(OBJPROP_XSIZE,m_table_visible_x_size);
   m_headers.SetInteger(OBJPROP_YSIZE,m_header_y_size);
//--- Set the frame offset within the image along the X and Y axes
   m_headers.SetInteger(OBJPROP_XOFFSET,0);
   m_headers.SetInteger(OBJPROP_YOFFSET,0);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the vertical scrollbar                                   |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateScrollV(void)
  {
//--- Store the form pointer
   m_scrollv.WindowPointer(m_wnd);
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X2()-m_scrollv.ScrollWidth());
   int y=CElement::CalculateYGap(CElementBase::Y());
//--- Set properties
   m_scrollv.Id(CElementBase::Id());
   m_scrollv.IsDropdown(CElementBase::IsDropdown());
   m_scrollv.XSize(m_scrollv.ScrollWidth());
   m_scrollv.YSize(m_y_size-m_scrollv.ScrollWidth()+1);
   m_scrollv.AnchorRightWindowSide(m_anchor_right_window_side);
   m_scrollv.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Creating the scrollbar
   if(!m_scrollv.CreateScroll(m_chart_id,m_subwin,x,y,m_table_y_size,m_table_visible_y_size))
      return(false);
//--- Hide, if it is not required now
   if(m_table_visible_y_size>m_table_y_size)
      m_scrollv.Hide();
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the horizontal scrollbar                                 |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateScrollH(void)
  {
//--- Store the form pointer
   m_scrollh.WindowPointer(m_wnd);
//--- Coordinates
   int x=CElement::CalculateXGap(CElementBase::X());
   int y=CElement::CalculateYGap(CElementBase::Y2()-m_scrollh.ScrollWidth());
//--- Set properties
   m_scrollh.Id(CElementBase::Id());
   m_scrollh.IsDropdown(CElementBase::IsDropdown());
   m_scrollh.XSize(m_area.XSize()-m_scrollh.ScrollWidth());
   m_scrollh.YSize(m_scrollh.ScrollWidth());
   m_scrollh.AnchorRightWindowSide(m_anchor_right_window_side);
   m_scrollh.AnchorBottomWindowSide(m_anchor_bottom_window_side);
//--- Creating the scrollbar
   if(!m_scrollh.CreateScroll(m_chart_id,m_subwin,x,y,m_table_x_size,m_table_visible_x_size))
      return(false);
//--- Hide, if it is not required now
   if(m_table_visible_x_size>m_table_x_size)
      m_scrollh.Hide();
//----
   return(true);
  }
//+------------------------------------------------------------------+
//| Create cursor of changing the column widths                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CreateColumnResizePointer(void)
  {
//--- Leave, if the mode of changing the column widths is disabled
   if(!m_column_resize_mode)
      return(true);
//--- Setting up properties
   m_column_resize.XGap(13);
   m_column_resize.YGap(14);
   m_column_resize.Id(CElementBase::Id());
   m_column_resize.Type(MP_X_RESIZE_RELATIVE);
//--- Creating an element
   if(!m_column_resize.CreatePointer(m_chart_id,m_subwin))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Returns the total number of icons in the specified cell          |
//+------------------------------------------------------------------+
int CCanvasTable::ImagesTotal(const uint column_index,const uint row_index)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Return the size of the icons array
   return(::ArraySize(m_columns[column_index].m_rows[row_index].m_images));
  }
//+------------------------------------------------------------------+
//| The minimum width of the columns                                 |
//+------------------------------------------------------------------+
void CCanvasTable::MinColumnWidth(const int width)
  {
//--- The column width is at least 3 pixels
   m_min_column_width=(width>3)? width : 3;
  }
//+------------------------------------------------------------------+
//| Set the size of the table                                        |
//+------------------------------------------------------------------+
void CCanvasTable::TableSize(const int columns_total,const int rows_total)
  {
//--- There must be at least one column
   m_columns_total=(columns_total<1)? 1 : columns_total;
//--- There must be at least two rows
   m_rows_total=(rows_total<1)? 1 : rows_total;
//--- Set the size to the arrays of rows, columns and headers
   ::ArrayResize(m_rows,m_rows_total);
   ::ArrayResize(m_columns,m_columns_total);
//--- Set the size of table arrays
   for(uint c=0; c<m_columns_total; c++)
     {
      ::ArrayResize(m_columns[c].m_rows,m_rows_total);
      //--- Initialize the column properties with the default values
      ColumnInitialize(c);
      //--- Initialization of the cell properties
      for(uint r=0; r<m_rows_total; r++)
         CellInitialize(c,r);
     }
  }
//+------------------------------------------------------------------+
//| Rebuilding the table                                             |
//+------------------------------------------------------------------+
void CCanvasTable::Rebuilding(const int columns_total,const int rows_total,const bool redraw=false)
  {
//--- Set the new size
   TableSize(columns_total,rows_total);
//--- Calculate and resize to the table
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Adds a column to the table at the specified index                |
//+------------------------------------------------------------------+
void CCanvasTable::AddColumn(const int column_index,const bool redraw=false)
  {
//--- Increase the array size by one element
   int array_size=(int)ColumnsTotal();
   m_columns_total=array_size+1;
   ::ArrayResize(m_columns,m_columns_total);
//--- Set the size of the rows arrays
   ::ArrayResize(m_columns[array_size].m_rows,m_rows_total);
//--- Adjustment of the index in case the range has been exceeded
   int checked_column_index=(column_index>=(int)m_columns_total)?(int)m_columns_total-1 : column_index;
//--- Shift other columns (starting from the end of the array to the index of the added column)
   for(int c=array_size; c>=checked_column_index; c--)
     {
      //--- Shift the sign of sorted array
      if(c==m_is_sorted_column_index && m_is_sorted_column_index!=WRONG_VALUE)
         m_is_sorted_column_index++;
      //--- Index of the previous column
      int prev_c=c-1;
      //--- Initialize the new column with the default values
      if(c==checked_column_index)
         ColumnInitialize(c);
      //--- Move the data from the previous column to the current column
      else
         ColumnCopy(c,prev_c);
      //---
      for(uint r=0; r<m_rows_total; r++)
        {
         //--- Initialize the new column cells with the default values
         if(c==checked_column_index)
           {
            CellInitialize(c,r);
            continue;
           }
         //--- Move the data from the previous column cell to the current column cell
         CellCopy(c,r,prev_c,r);
        }
     }
//--- Calculate and resize to the table
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Removes a column from the table at the specified index           |
//+------------------------------------------------------------------+
void CCanvasTable::DeleteColumn(const int column_index,const bool redraw=false)
  {
//--- Get the size of the array of columns
   int array_size=(int)ColumnsTotal();
//--- Adjustment of the index in case the range has been exceeded
   int checked_column_index=(column_index>=array_size)? array_size-1 : column_index;
//--- Shift other columns (starting from the specified index to the last column)
   for(int c=checked_column_index; c<array_size-1; c++)
     {
      //--- Shift the sign of sorted array
      if(c!=checked_column_index)
        {
         if(c==m_is_sorted_column_index && m_is_sorted_column_index!=WRONG_VALUE)
            m_is_sorted_column_index--;
        }
      //--- Zero, if a sorted column was removed
      else
         m_is_sorted_column_index=WRONG_VALUE;
      //--- Index of the next column
      int next_c=c+1;
      //--- Move the data from the next column to the current column
      ColumnCopy(c,next_c);
      //--- Move the data from the next column cells to the current column cells
      for(uint r=0; r<m_rows_total; r++)
         CellCopy(c,r,next_c,r);
     }
//--- Decrease the array of columns by one element
   m_columns_total=array_size-1;
   ::ArrayResize(m_columns,m_columns_total);
//--- Calculate and resize to the table
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Adds a row to the table at the specified index                   |
//+------------------------------------------------------------------+
void CCanvasTable::AddRow(const int row_index,const bool redraw=false)
  {
//--- Increase the array size by one element
   int array_size=(int)RowsTotal();
   m_rows_total=array_size+1;
//--- Set the size of the rows arrays
   for(uint i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_rows,m_rows_total);
      ::ArrayResize(m_columns[i].m_rows,m_rows_total);
     }
//--- Adjustment of the index in case the range has been exceeded
   int checked_row_index=(row_index>=(int)m_rows_total)?(int)m_rows_total-1 : row_index;
//--- Shift other rows (starting from the end of the array to the index of the added row)
   for(int c=0; c<(int)m_columns_total; c++)
     {
      for(int r=array_size; r>=checked_row_index; r--)
        {
         //--- Initialize the new row cells with the default values
         if(r==checked_row_index)
           {
            CellInitialize(c,r);
            continue;
           }
         //--- Index of the previous row
         uint prev_r=r-1;
         //--- Move the data from the previous row cell to the current row cell
         CellCopy(c,r,c,prev_r);
        }
     }
//--- Calculate and resize to the table
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Removes a row from the table at the specified index              |
//+------------------------------------------------------------------+
void CCanvasTable::DeleteRow(const int row_index,const bool redraw=false)
  {
//--- Get the size of the lines array
   int array_size=(int)RowsTotal();
//--- Adjustment of the index in case the range has been exceeded
   int checked_row_index=(row_index>=(int)m_rows_total)?(int)m_rows_total-1 : row_index;
//--- Shift other rows (starting from the specified index to the last row)
   for(int c=0; c<(int)m_columns_total; c++)
     {
      for(int r=checked_row_index; r<array_size-1; r++)
        {
         //--- Index of the next row
         uint next_r=r+1;
         //--- Move the data from the next row cell to the current row cell
         CellCopy(c,r,c,next_r);
        }
     }
//--- Decrease the rows array size by one element
   m_rows_total=array_size-1;
//--- Set the size of the rows arrays
   for(uint i=0; i<m_columns_total; i++)
     {
      ::ArrayResize(m_rows,m_rows_total);
      ::ArrayResize(m_columns[i].m_rows,m_rows_total);
     }
//--- Calculate and resize to the table
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Clears the table. Only one column and one row are left.     |
//+------------------------------------------------------------------+
void CCanvasTable::Clear(const bool redraw=false)
  {
//--- Set the minimum size of 1x1
   TableSize(1,1);
//--- Set the default values
   m_selected_item_text     ="";
   m_selected_item          =WRONG_VALUE;
   m_last_sort_direction    =SORT_ASCEND;
   m_is_sorted_column_index =WRONG_VALUE;
//--- Calculate and resize to the table
   RecalculateAndResizeTable(redraw);
  }
//+------------------------------------------------------------------+
//| Fills the array of headers at the specified index                |
//+------------------------------------------------------------------+
void CCanvasTable::SetHeaderText(const uint column_index,const string value)
  {
//--- Checking for exceeding the column range
   if(!CheckOutOfColumnRange(column_index))
      return;
//--- Store the value into the array
   m_columns[column_index].m_header_text=value;
  }
//+------------------------------------------------------------------+
//| Fills the array of text alignment modes                          |
//+------------------------------------------------------------------+
void CCanvasTable::TextAlign(const ENUM_ALIGN_MODE &array[])
  {
   int total=0;
//--- Leave, if a zero-sized array was passed
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Store the values in the structure
   for(int c=0; c<total; c++)
      m_columns[c].m_text_align=array[c];
  }
//+------------------------------------------------------------------+
//| Fills the array of text offset along the X axis within a cell    |
//+------------------------------------------------------------------+
void CCanvasTable::TextXOffset(const int &array[])
  {
   int total=0;
//--- Leave, if a zero-sized array was passed
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Store the values in the structure
   for(int c=0; c<total; c++)
      m_columns[c].m_text_x_offset=array[c];
  }
//+------------------------------------------------------------------+
//| Fills the array of column widths                                 |
//+------------------------------------------------------------------+
void CCanvasTable::ColumnsWidth(const int &array[])
  {
   int total=0;
//--- Leave, if a zero-sized array was passed
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Store the values in the structure
   for(int c=0; c<total; c++)
      m_columns[c].m_width=array[c];
  }
//+------------------------------------------------------------------+
//| Image offsets from the cell edges along the X axis               |
//+------------------------------------------------------------------+
void CCanvasTable::ImageXOffset(const int &array[])
  {
   int total=0;
//--- Leave, if a zero-sized array was passed
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Store the values in the structure
   for(int c=0; c<total; c++)
      m_columns[c].m_image_x_offset=array[c];
  }
//+------------------------------------------------------------------+
//| Image offsets from the cell edges along the Y axis               |
//+------------------------------------------------------------------+
void CCanvasTable::ImageYOffset(const int &array[])
  {
   int total=0;
//--- Leave, if a zero-sized array was passed
   if((total=CheckArraySize(array))==WRONG_VALUE)
      return;
//--- Store the values in the structure
   for(int c=0; c<total; c++)
      m_columns[c].m_image_y_offset=array[c];
  }
//+------------------------------------------------------------------+
//| Set the data type of the specified column                        |
//+------------------------------------------------------------------+
void CCanvasTable::DataType(const uint column_index,const ENUM_DATATYPE type)
  {
//--- Checking for exceeding the column range
   if(!CheckOutOfColumnRange(column_index))
      return;
//--- Set the data type for the specified column
   m_columns[column_index].m_type=type;
  }
//+------------------------------------------------------------------+
//| Get the data type of the specified column                        |
//+------------------------------------------------------------------+
ENUM_DATATYPE CCanvasTable::DataType(const uint column_index)
  {
//--- Checking for exceeding the column range
   if(!CheckOutOfColumnRange(column_index))
      return(WRONG_VALUE);
//--- Return the data type for the specified column
   return(m_columns[column_index].m_type);
  }
//+------------------------------------------------------------------+
//| Sets the cell type                                               |
//+------------------------------------------------------------------+
void CCanvasTable::CellType(const uint column_index,const uint row_index,const ENUM_TYPE_CELL type)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Set the cell type
   m_columns[column_index].m_rows[row_index].m_type=type;
  }
//+------------------------------------------------------------------+
//| Gets the cell type                                               |
//+------------------------------------------------------------------+
ENUM_TYPE_CELL CCanvasTable::CellType(const uint column_index,const uint row_index)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Return the data type for the specified column
   return(m_columns[column_index].m_rows[row_index].m_type);
  }
//+------------------------------------------------------------------+
//| Set icons to the specified cell                                  |
//+------------------------------------------------------------------+
void CCanvasTable::SetImages(const uint column_index,const uint row_index,const string &bmp_file_path[])
  {
   int total=0;
//--- Leave, if a zero-sized array was passed
   if((total=CheckArraySize(bmp_file_path))==WRONG_VALUE)
      return;
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Resize the arrays
   ::ArrayResize(m_columns[column_index].m_rows[row_index].m_images,total);
//---
   for(int i=0; i<total; i++)
     {
      //--- The first icon of the array is selected by default
      m_columns[column_index].m_rows[row_index].m_selected_image=0;
      //--- Write the passed icon to the array and store its size
      if(!::ResourceReadImage(bmp_file_path[i],m_columns[column_index].m_rows[row_index].m_images[i].m_image_data,
         m_columns[column_index].m_rows[row_index].m_images[i].m_image_width,
         m_columns[column_index].m_rows[row_index].m_images[i].m_image_height))
        {
         ::Print(__FUNCTION__," > error: ",::GetLastError());
         return;
        }
     }
  }
//+------------------------------------------------------------------+
//| Changes the icon in the specified cell                           |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeImage(const uint column_index,const uint row_index,const uint image_index,const bool redraw=false)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Get the number of cell icons
   int images_total=ImagesTotal(column_index,row_index);
//--- Leave, if (1) there are no icons or (2) out of range
   if(images_total==WRONG_VALUE || image_index>=(uint)images_total)
      return;
//--- Leave, if the specified icon matches the selected one
   if(image_index==m_columns[column_index].m_rows[row_index].m_selected_image)
      return;
//--- Store the index of the selected icon of the cell
   m_columns[column_index].m_rows[row_index].m_selected_image=(int)image_index;
//--- Redraw the cell, if specified
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Returns the image index in the specified cell                    |
//+------------------------------------------------------------------+
int CCanvasTable::SelectedImageIndex(const uint column_index,const uint row_index)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return(WRONG_VALUE);
//--- Return the value
   return(m_columns[column_index].m_rows[row_index].m_selected_image);
  }
//+------------------------------------------------------------------+
//| Fill the text color array                                        |
//+------------------------------------------------------------------+
void CCanvasTable::TextColor(const uint column_index,const uint row_index,const color clr,const bool redraw=false)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Store the text color in the common array
   m_columns[column_index].m_rows[row_index].m_text_color=clr;
//--- Redraw the cell, if specified
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Fills the array by the specified indexes                         |
//+------------------------------------------------------------------+
void CCanvasTable::SetValue(const uint column_index,const uint row_index,const string value="",const uint digits=0,const bool redraw=false)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return;
//--- Store the value into the array:
//    String
   if(m_columns[column_index].m_type==TYPE_STRING)
      m_columns[column_index].m_rows[row_index].m_full_text=value;
//--- Double
   else if(m_columns[column_index].m_type==TYPE_DOUBLE)
     {
      m_columns[column_index].m_rows[row_index].m_digits=digits;
      double type_value=::StringToDouble(value);
      m_columns[column_index].m_rows[row_index].m_full_text=::DoubleToString(type_value,digits);
     }
//--- Time
   else if(m_columns[column_index].m_type==TYPE_DATETIME)
     {
      datetime type_value=::StringToTime(value);
      m_columns[column_index].m_rows[row_index].m_full_text=::TimeToString(type_value);
     }
//--- Any other type will be stored as a string
   else
      m_columns[column_index].m_rows[row_index].m_full_text=value;
//--- Adjust and store the text, if it does not fit the cell
   m_columns[column_index].m_rows[row_index].m_short_text=CorrectingText(column_index,row_index);
//--- Redraw the cell, if specified
   if(redraw)
      RedrawCell(column_index,row_index);
  }
//+------------------------------------------------------------------+
//| Return value at the specified index                              |
//+------------------------------------------------------------------+
string CCanvasTable::GetValue(const uint column_index,const uint row_index)
  {
//--- Checking for exceeding the array range
   if(!CheckOutOfRange(column_index,row_index))
      return("");
//--- Return the value
   return(m_columns[column_index].m_rows[row_index].m_full_text);
  }
//+------------------------------------------------------------------+
//| Horizontal scrollbar of the text box                             |
//+------------------------------------------------------------------+
void CCanvasTable::HorizontalScrolling(const int pos=WRONG_VALUE)
  {
//--- To determine the position of the thumb
   int index=0;
//--- Index of the last position
   int last_pos_index=int(m_table_x_size-m_table_visible_x_size);
//--- Adjustment in case the range has been exceeded
   if(pos<0)
      index=last_pos_index;
   else
      index=(pos>last_pos_index)? last_pos_index : pos;
//--- Move the scrollbar thumb
   m_scrollh.MovingThumb(index);
//--- Shift the text box
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Vertical scrollbar of the text box                               |
//+------------------------------------------------------------------+
void CCanvasTable::VerticalScrolling(const int pos=WRONG_VALUE)
  {
//--- To determine the position of the thumb
   int index=0;
//--- Index of the last position
   int last_pos_index=int(m_table_y_size-m_table_visible_y_size);
//--- Adjustment in case the range has been exceeded
   if(pos<0)
      index=last_pos_index;
   else
      index=(pos>last_pos_index)? last_pos_index : pos;
//--- Move the scrollbar thumb
   m_scrollv.MovingThumb(index);
//--- Shift the text box
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Shift the table relative to the scrollbars                       |
//+------------------------------------------------------------------+
void CCanvasTable::ShiftTable(void)
  {
//--- Get the current positions of sliders of the vertical and horizontal scrollbars
   int h=m_scrollh.CurrentPos();
   int v=m_scrollv.CurrentPos();
//--- Calculation of the table position relative to the scrollbar sliders
   long c=(m_table_x_size>m_table_visible_x_size)? h : 0;
   long r=(m_table_y_size>m_table_visible_y_size)? v : 0;
//--- Shift of the table
   m_table.SetInteger(OBJPROP_XOFFSET,c);
   m_table.SetInteger(OBJPROP_YOFFSET,r);
   m_headers.SetInteger(OBJPROP_XOFFSET,c);
  }
//+------------------------------------------------------------------+
//| Sort the data according to the specified column                  |
//+------------------------------------------------------------------+
void CCanvasTable::SortData(const uint column_index=0)
  {
//--- Index to start sorting from
   uint first_index=0;
//--- The last index
   uint last_index=m_rows_total-1;
//--- The first time it will be sorted in ascending order, every time after that it will be sorted in the opposite direction
   if(m_is_sorted_column_index==WRONG_VALUE || column_index!=m_is_sorted_column_index || m_last_sort_direction==SORT_DESCEND)
      m_last_sort_direction=SORT_ASCEND;
   else
      m_last_sort_direction=SORT_DESCEND;
//--- Store the index of the last sorted data column
   m_is_sorted_column_index=(int)column_index;
//--- Sorting
   QuickSort(first_index,last_index,column_index,m_last_sort_direction);
//--- Update the table
   UpdateTable(true);
  }
//+------------------------------------------------------------------+
//| Updating the table                                               |
//+------------------------------------------------------------------+
void CCanvasTable::UpdateTable(const bool redraw=false)
  {
//--- Redraw the table, if specified
   if(redraw)
      DrawTable();
//--- Update the table
   m_table.Update();
  }
//+------------------------------------------------------------------+
//| Handling clicking on a header                                    |
//+------------------------------------------------------------------+
bool CCanvasTable::OnClickHeaders(const string clicked_object)
  {
//--- Leave, if (1) the sorting mode is disabled or (2) in the process of changing the column width
   if(!m_is_sort_mode || m_column_resize_control!=WRONG_VALUE)
      return(false);
//--- Leave, if the scrollbar is active
   if(m_scrollv.ScrollState() || m_scrollh.ScrollState())
      return(false);
//--- Leave, if it has a different object name
   if(m_headers.Name()!=clicked_object)
      return(false);
//--- For determining the column index
   uint column_index=0;
//--- Get the relative X coordinate below the mouse cursor
   int x=m_mouse.RelativeX(m_headers);
//--- Determine the clicked header
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- If the header is found, store its index
      if(x>=m_columns[c].m_x && x<=m_columns[c].m_x2)
        {
         column_index=c;
         break;
        }
     }
//--- Sort the data according to the specified column
   SortData(column_index);
//--- Send a message about it
   ::EventChartCustom(m_chart_id,ON_SORT_DATA,CElementBase::Id(),m_is_sorted_column_index,::EnumToString(DataType(column_index)));
   return(true);
  }
//+------------------------------------------------------------------+
//| Handling clicking on the table                                   |
//+------------------------------------------------------------------+
bool CCanvasTable::OnClickTable(const string clicked_object)
  {
//--- Leave, if (1) row selection mode is disabled or (2) in the process of changing the column width
   if(m_column_resize_control!=WRONG_VALUE)
      return(false);
//--- Leave, if the scrollbar is active
   if(m_scrollv.ScrollState() || m_scrollh.ScrollState())
      return(false);
//--- Leave, if it has a different object name
   if(m_table.Name()!=clicked_object)
      return(false);
//--- Determine the clicked row
   int r=PressedRowIndex();
//--- Determine the clicked cell
   int c=PressedCellColumnIndex();
//--- Check if the control in the cell was activated
   bool is_cell_element=CheckCellElement(c,r);
//--- If (1) the row selection mode is enabled and (2) cell control is not activated
   if(m_selectable_row && !is_cell_element)
     {
      //--- Change the color
      RedrawRow(true);
      m_table.Update();
      //--- Send a message about it
      ::EventChartCustom(m_chart_id,ON_CLICK_LIST_ITEM,CElementBase::Id(),m_selected_item,string(c)+"_"+string(r));
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Handling double clicking on the table                            |
//+------------------------------------------------------------------+
bool CCanvasTable::OnDoubleClickTable(const string clicked_object)
  {
   if(!m_table.MouseFocus())
      return(false);
//--- Determine the clicked row
   int r=PressedRowIndex();
//--- Determine the clicked cell
   int c=PressedCellColumnIndex();
//--- Check if the control in the cell was activated and return the result
   return(CheckCellElement(c,r,true));
  }
//+------------------------------------------------------------------+
//| Returns the index of the clicked row                             |
//+------------------------------------------------------------------+
int CCanvasTable::PressedRowIndex(void)
  {
   int index=0;
//--- Get the relative Y coordinate below the mouse cursor
   int y=m_mouse.RelativeY(m_table);
//--- Determine the clicked row
   for(uint r=0; r<m_rows_total; r++)
     {
      //--- If the click was not on this line, go to the next
      if(!(y>=m_rows[r].m_y && y<=m_rows[r].m_y2))
         continue;
      //--- If the row selection mode is disabled, store the row index
      if(!m_selectable_row)
         index=(int)r;
      else
        {
         //--- If clicked a selected row
         if(r==m_selected_item)
           {
            //--- Deselect, if not prohibited
            if(!m_is_without_deselect)
              {
               m_prev_selected_item =m_selected_item;
               m_selected_item      =WRONG_VALUE;
               m_selected_item_text ="";
              }
            break;
           }
         //--- Store the row index and the row of the first cell
         m_prev_selected_item =(m_selected_item==WRONG_VALUE)? (int)r : m_selected_item;
         m_selected_item      =(int)r;
         m_selected_item_text =m_columns[0].m_rows[r].m_full_text;
        }
      break;
     }
//--- If the row selection mode is enabled, determine the clicked row index
   if(m_selectable_row)
      index=(m_selected_item==WRONG_VALUE)? m_prev_selected_item : m_selected_item;
//--- Return the index
   return(index);
  }
//+------------------------------------------------------------------+
//| Returns the index of the clicked cell column                     |
//+------------------------------------------------------------------+
int CCanvasTable::PressedCellColumnIndex(void)
  {
   int index=0;
//--- Get the relative X coordinate below the mouse cursor
   int x=m_mouse.RelativeX(m_table);
//--- Determine the clicked cell
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- If this cell was clicked, store the column index
      if(x>=m_columns[c].m_x && x<=m_columns[c].m_x2)
        {
         index=(int)c;
         break;
        }
     }
//--- Return the column index
   return(index);
  }
//+------------------------------------------------------------------+
//| Check if the cell control was activated when clicked             |
//+------------------------------------------------------------------+
bool CCanvasTable::CheckCellElement(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Leave, if the cell has no controls
   if(m_columns[column_index].m_rows[row_index].m_type==CELL_SIMPLE)
      return(false);
//---
   switch(m_columns[column_index].m_rows[row_index].m_type)
     {
      //--- If it is a button cell
      case CELL_BUTTON :
        {
         if(!CheckPressedButton(column_index,row_index,double_click))
            return(false);
         //---
         break;
        }
      //--- If it is a checkbox cell
      case CELL_CHECKBOX :
        {
         if(!CheckPressedCheckBox(column_index,row_index,double_click))
            return(false);
         //---
         break;
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Check if the button in the cell was clicked                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CheckPressedButton(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Leave, if there are no images in the cell
   if(ImagesTotal(column_index,row_index)<1)
     {
      ::Print(__FUNCTION__," > Assign at least one image to the button cell!");
      return(false);
     }
//--- Get the relative coordinates under the mouse cursor
   int x=m_mouse.RelativeX(m_table);
// --- Get the right border of the image
   int image_x  =int(m_columns[column_index].m_x+m_columns[column_index].m_image_x_offset);
   int image_x2 =int(image_x+m_columns[column_index].m_rows[row_index].m_images[0].m_image_width);
//--- Leave, if the click was not on the image
   if(x>image_x2)
      return(false);
   else
     {
      //--- If this is not a double click, send a message
      if(!double_click)
        {
         int image_index=m_columns[column_index].m_rows[row_index].m_selected_image;
         ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElementBase::Id(),image_index,string(column_index)+"_"+string(row_index));
        }
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Check if the checkbox in the cell was clicked                    |
//+------------------------------------------------------------------+
bool CCanvasTable::CheckPressedCheckBox(const int column_index,const int row_index,const bool double_click=false)
  {
//--- Leave, if there are no images in the cell
   if(ImagesTotal(column_index,row_index)<2)
     {
      ::Print(__FUNCTION__," > Assign at least two images to the checkbox cell!");
      return(false);
     }
//--- Get the relative coordinates under the mouse cursor
   int x=m_mouse.RelativeX(m_table);
// --- Get the right border of the image
   int image_x  =int(m_columns[column_index].m_x+m_image_x_offset);
   int image_x2 =int(image_x+m_columns[column_index].m_rows[row_index].m_images[0].m_image_width);
//--- Leave, if (1) the click was not on the image and (2) it is not a double click
   if(x>image_x2 && !double_click)
      return(false);
   else
     {
      //--- Current index of the selected image
      int image_i=m_columns[column_index].m_rows[row_index].m_selected_image;
      //--- Determine the next index for the image
      int next_i=(image_i<ImagesTotal(column_index,row_index)-1)? ++image_i : 0;
      //--- Select the next image and update the table
      ChangeImage(column_index,row_index,next_i,true);
      m_table.Update(false);
      //--- Send a message about it
      ::EventChartCustom(m_chart_id,ON_CLICK_CHECKBOX,CElementBase::Id(),next_i,string(column_index)+"_"+string(row_index));
     }
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Quicksort algorithm                                              |
//+------------------------------------------------------------------+
void CCanvasTable::QuickSort(uint beg,uint end,uint column,const _ENUM_SORT_MODE mode=SORT_ASCEND)
  {
   uint   r1         =beg;
   uint   r2         =end;
   uint   c          =column;
   string temp       =NULL;
   string value      =NULL;
   uint   data_total =m_rows_total-1;
//--- Run the algorithm while the left index is less than the rightmost index
   while(r1<end)
     {
      //--- Get the value from the middle of the row
      value=m_columns[c].m_rows[(beg+end)>>1].m_full_text;
      //--- Run the algorithm while the left index is less than the found right index
      while(r1<r2)
        {
         //--- Shift the index to the right while finding the value on the specified condition
         while(CheckSortCondition(c,r1,value,(mode==SORT_ASCEND)? false : true))
           {
            //--- Checking for exceeding the array range
            if(r1==data_total)
               break;
            r1++;
           }
         //--- Shift the index to the left while finding the value on the specified condition
         while(CheckSortCondition(c,r2,value,(mode==SORT_ASCEND)? true : false))
           {
            //--- Checking for exceeding the array range
            if(r2==0)
               break;
            r2--;
           }
         //--- If the left index is still not greater than the right index
         if(r1<=r2)
           {
            //--- Swap the values
            Swap(r1,r2);
            //--- If the left limit has been reached
            if(r2==0)
              {
               r1++;
               break;
              }
            //---
            r1++;
            r2--;
           }
        }
      //--- Recursive continuation of the algorithm, until the beginning of the range is reached
      if(beg<r2)
         QuickSort(beg,r2,c,mode);
      //--- Narrow the range for the next iteration
      beg=r1;
      r2=end;
     }
  }
//+------------------------------------------------------------------+
//| Comparing the values on the specified sorting condition          |
//+------------------------------------------------------------------+
//| direction: true (>), false (<)                                   |
//+------------------------------------------------------------------+
bool CCanvasTable::CheckSortCondition(uint column_index,uint row_index,const string check_value,const bool direction)
  {
   bool condition=false;
//---
   switch(m_columns[column_index].m_type)
     {
      case TYPE_STRING :
        {
         string v1=m_columns[column_index].m_rows[row_index].m_full_text;
         string v2=check_value;
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
      //---
      case TYPE_DOUBLE :
        {
         double v1=double(m_columns[column_index].m_rows[row_index].m_full_text);
         double v2=double(check_value);
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
      //---
      case TYPE_DATETIME :
        {
         datetime v1=::StringToTime(m_columns[column_index].m_rows[row_index].m_full_text);
         datetime v2=::StringToTime(check_value);
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
      //---
      default :
        {
         long v1=(long)m_columns[column_index].m_rows[row_index].m_full_text;
         long v2=(long)check_value;
         condition=(direction)? v1>v2 : v1<v2;
         break;
        }
     }
//---
   return(condition);
  }
//+------------------------------------------------------------------+
//| Swap the elements                                                |
//+------------------------------------------------------------------+
void CCanvasTable::Swap(uint r1,uint r2)
  {
//--- Iterate over all columns in a loop
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Swap the full text
      string temp_text                    =m_columns[c].m_rows[r1].m_full_text;
      m_columns[c].m_rows[r1].m_full_text =m_columns[c].m_rows[r2].m_full_text;
      m_columns[c].m_rows[r2].m_full_text =temp_text;
      //--- Swap the short text
      temp_text                            =m_columns[c].m_rows[r1].m_short_text;
      m_columns[c].m_rows[r1].m_short_text =m_columns[c].m_rows[r2].m_short_text;
      m_columns[c].m_rows[r2].m_short_text =temp_text;
      //--- Swap the number of decimal places
      uint temp_digits                 =m_columns[c].m_rows[r1].m_digits;
      m_columns[c].m_rows[r1].m_digits =m_columns[c].m_rows[r2].m_digits;
      m_columns[c].m_rows[r2].m_digits =temp_digits;
      //--- Swap the text color
      color temp_text_color                =m_columns[c].m_rows[r1].m_text_color;
      m_columns[c].m_rows[r1].m_text_color =m_columns[c].m_rows[r2].m_text_color;
      m_columns[c].m_rows[r2].m_text_color =temp_text_color;
      //--- Swap the index of the selected icon
      int temp_selected_image                  =m_columns[c].m_rows[r1].m_selected_image;
      m_columns[c].m_rows[r1].m_selected_image =m_columns[c].m_rows[r2].m_selected_image;
      m_columns[c].m_rows[r2].m_selected_image =temp_selected_image;
      //--- Check if the cells contain images
      int r1_images_total=::ArraySize(m_columns[c].m_rows[r1].m_images);
      int r2_images_total=::ArraySize(m_columns[c].m_rows[r2].m_images);
      //--- Go to the next column, if both cells have no images
      if(r1_images_total<1 && r2_images_total<1)
         continue;
      //--- Swap the images
      CTImage r1_temp_images[];
      //---
      ::ArrayResize(r1_temp_images,r1_images_total);
      for(int i=0; i<r1_images_total; i++)
         ImageCopy(r1_temp_images,m_columns[c].m_rows[r1].m_images,i);
      //---
      ::ArrayResize(m_columns[c].m_rows[r1].m_images,r2_images_total);
      for(int i=0; i<r2_images_total; i++)
         ImageCopy(m_columns[c].m_rows[r1].m_images,m_columns[c].m_rows[r2].m_images,i);
      //---
      ::ArrayResize(m_columns[c].m_rows[r2].m_images,r1_images_total);
      for(int i=0; i<r1_images_total; i++)
         ImageCopy(m_columns[c].m_rows[r2].m_images,r1_temp_images,i);
     }
  }
//+------------------------------------------------------------------+
//| Draw table                                                       |
//+------------------------------------------------------------------+
void CCanvasTable::DrawTable(const bool only_visible=false)
  {
//--- If not indicated to redraw only the visible part of the table
   if(!only_visible)
     {
      //--- Set the row indexes of the entire table from the beginning to the end
      m_visible_table_from_index =0;
      m_visible_table_to_index   =m_rows_total;
     }
//--- Get the row indexes of the visible part of the table
   else
      VisibleTableIndexes();
//--- Draw the background of the table rows
   DrawRows();
//--- Draw a selected row
   DrawSelectedRow();
//--- Draw grid
   DrawGrid();
//--- Draw icon
   DrawImages();
//--- Draw text
   DrawText();
//--- Display the latest drawn changes
   m_table.Update();
//--- Update headers, if they are enabled
   if(m_show_headers)
     {
      DrawTableHeaders();
      m_headers.Update();
     }
//--- Adjustment of the table relative to the scrollbars
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Redraws the specified cell of the table                          |
//+------------------------------------------------------------------+
void CCanvasTable::RedrawCell(const int column_index,const int row_index)
  {
//--- Coordinates
   int x1=m_columns[column_index].m_x+1;
   int x2=m_columns[column_index].m_x2-1;
   int y1=m_rows[row_index].m_y+1;
   int y2=m_rows[row_index].m_y2-1;
//--- To calculate the coordinates
   int  x=0,y=0;
//--- To check the focus
   bool is_row_focus=false;
//--- If the row highlighting mode is enabled
   if(m_lights_hover)
     {
      //--- (1) Get the relative Y coordinate of the mouse cursor and (2) the focus on the specified table row
      y=m_mouse.RelativeY(m_table);
      is_row_focus=(y>m_rows[row_index].m_y && y<=m_rows[row_index].m_y2);
     }
//--- Draw the cell background
   m_table.FillRectangle(x1,y1,x2,y2,RowColorCurrent(row_index,is_row_focus));
//--- Draw the icon, if (1) it is present in this cell and (2) the text of this column is aligned to the left
   if(ImagesTotal(column_index,row_index)>0 && m_columns[column_index].m_text_align==ALIGN_LEFT)
      DrawImage(column_index,row_index);
//--- Get the text alignment mode
   uint text_align=TextAlign(column_index,TA_TOP);
//--- Draw the text
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Get the X coordinate of the text
      x=TextX(c);
      //--- Stop the cycle
      if(c==column_index)
         break;
     }
//--- (1) Calculate the Y coordinate, and (2) draw the text
   y=y1+m_text_y_offset-1;
   m_table.TextOut(x,y,m_columns[column_index].m_rows[row_index].m_short_text,TextColor(column_index,row_index),text_align);
  }
//+------------------------------------------------------------------+
//| Redraws the specified table row according to the specified mode  |
//+------------------------------------------------------------------+
void CCanvasTable::RedrawRow(const bool is_selected_row=false)
  {
//--- The current and the previous row indexes
   int item_index      =WRONG_VALUE;
   int prev_item_index =WRONG_VALUE;
//--- Initialization of the row indexes relative to the specified mode
   if(is_selected_row)
     {
      item_index      =m_selected_item;
      prev_item_index =m_prev_selected_item;
     }
   else
     {
      item_index      =m_item_index_focus;
      prev_item_index =m_prev_item_index_focus;
     }
//--- Leave, if the indexes are not defined
   if(prev_item_index==WRONG_VALUE && item_index==WRONG_VALUE)
      return;
//--- The number of rows and columns for drawing
   uint rows_total    =(item_index!=WRONG_VALUE && prev_item_index!=WRONG_VALUE && item_index!=prev_item_index)? 2 : 1;
   uint columns_total =m_columns_total-1;
//--- Coordinates
   int x1=1,x2=m_table_x_size;
   int y1[2]={0},y2[2]={0};
//--- Array for values in a certain sequence
   int indexes[2];
//--- If (1) the mouse cursor moved down or if (2) entering for the first time
   if(item_index>m_prev_item_index_focus || item_index==WRONG_VALUE)
     {
      indexes[0]=(item_index==WRONG_VALUE || prev_item_index!=WRONG_VALUE)? prev_item_index : item_index;
      indexes[1]=item_index;
     }
//--- If the mouse cursor moved up
   else
     {
      indexes[0]=item_index;
      indexes[1]=prev_item_index;
     }
//--- Draw the background of rows
   for(uint r=0; r<rows_total; r++)
     {
      //--- Calculate the coordinates of the upper and lower boundaries of the row
      y1[r]=m_rows[indexes[r]].m_y+1;
      y2[r]=m_rows[indexes[r]].m_y2-1;
      //--- Determine the focus on the row with respect to the highlighting mode
      bool is_item_focus=false;
      if(!m_lights_hover)
         is_item_focus=(indexes[r]==item_index && item_index!=WRONG_VALUE);
      else
         is_item_focus=(item_index==WRONG_VALUE)?(indexes[r]==prev_item_index) :(indexes[r]==item_index);
      //--- Draw the row background
      m_table.FillRectangle(x1,y1[r],x2,y2[r],RowColorCurrent(indexes[r],is_item_focus));
     }
//--- Grid color
   uint clr=::ColorToARGB(m_grid_color);
//--- Draw the borders
   for(uint r=0; r<rows_total; r++)
     {
      for(uint c=0; c<columns_total; c++)
         m_table.Line(m_columns[c].m_x2,y1[r],m_columns[c].m_x2,y2[r],clr);
     }
//--- Draw the icons
   for(uint r=0; r<rows_total; r++)
     {
      for(uint c=0; c<m_columns_total; c++)
        {
         //--- Draw the icon, if (1) it is present in this cell and (2) the text of this column is aligned to the left
         if(ImagesTotal(c,indexes[r])>0 && m_columns[c].m_text_align==ALIGN_LEFT)
            DrawImage(c,indexes[r]);
        }
     }
//--- To calculate the coordinates
   int x=0,y=0;
//--- Text alignment mode
   uint text_align=0;
//--- Draw the text
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Get (1) the X coordinate of the text and (2) the text alignment mode
      x          =TextX(c);
      text_align =TextAlign(c,TA_TOP);
      //---
      for(uint r=0; r<rows_total; r++)
        {
         //--- (1) Calculate the coordinate and (2) draw the text
         y=m_rows[indexes[r]].m_y+m_text_y_offset;
         m_table.TextOut(x,y,m_columns[c].m_rows[indexes[r]].m_short_text,TextColor(c,indexes[r]),text_align);
        }
     }
  }
//+------------------------------------------------------------------+
//| Draws the background of the table rows                           |
//+------------------------------------------------------------------+
void CCanvasTable::DrawRows(void)
  {
//--- Coordinates of the mouse cursor
   int y=0;
//--- Coordinates of the headers
   int x1=0,x2=m_table_x_size;
   int y1=0,y2=0;
   bool is_row_focus=false;
//--- Get the relative X coordinate below the mouse cursor
   if(::CheckPointer(m_mouse)!=POINTER_INVALID)
      y=m_mouse.RelativeY(m_table);
//--- Formatting in Zebra style
   for(uint r=m_visible_table_from_index; r<m_visible_table_to_index; r++)
     {
      //--- Calculation of the coordinates of the row borders and storing the values
      m_rows[r].m_y  =y1 =(int)(r*m_cell_y_size);
      m_rows[r].m_y2 =y2 =y1+m_cell_y_size;
      //--- Check the focus
      is_row_focus=(m_lights_hover)?(y>y1 && y<y2) : false;
      //--- Draw the row background
      m_table.FillRectangle(x1,y1,x2,y2,RowColorCurrent(r,is_row_focus));
     }
  }
//+------------------------------------------------------------------+
//| Draws the selected row                                           |
//+------------------------------------------------------------------+
void CCanvasTable::DrawSelectedRow(void)
  {
//--- Leave, if there is no selected row
   if(m_selected_item==WRONG_VALUE)
      return;
//--- Set the initial coordinates for checking the condition
   int y_offset=m_selected_item*m_cell_y_size;
//--- Coordinates
   int x1=0;
   int y1=y_offset;
   int x2=m_table_x_size;
   int y2=y_offset+m_cell_y_size;
//--- Draw a filled rectangle
   m_table.FillRectangle(x1,y1,x2,y2,::ColorToARGB(m_selected_row_color));
  }
//+------------------------------------------------------------------+
//| Draw grid                                                        |
//+------------------------------------------------------------------+
void CCanvasTable::DrawGrid(void)
  {
//--- Grid color
   uint clr=::ColorToARGB(m_grid_color);
//--- Size of canvas for drawing
   int x_size=m_table_x_size-1;
   int y_size=m_table_y_size-2;
//--- Coordinates
   int x1=0,x2=0,y1=0,y2=0;
//--- Horizontal lines
   x1=0; y1=0; x2=x_size; y2=0;
   for(uint i=0; i<m_rows_total; i++)
      m_table.Line(x1,m_rows[i].m_y,x2,m_rows[i].m_y,clr);
//--- The lower border of the table
   x1=0; y1=y_size; x2=x_size; y2=y_size;
   m_table.Line(x1,y1,x2,y2,clr);
//--- Vertical lines
   x1=0; y1=0; x2=0; y2=y_size;
   for(uint i=0; i<m_columns_total; i++)
     {
      m_table.Line(x1,y1,x2,y2,clr);
      m_columns[i].m_x2=x2=x1+=m_columns[i].m_width;
      //--- Store the X coordinate of the column
      if(i>0)
        {
         uint prev_i=i-1;
         m_columns[i].m_x=m_columns[prev_i].m_x+m_columns[prev_i].m_width;
        }
     }
//--- The right border of the table
   x1=x_size; y1=0; x2=x_size; y2=y_size;
   m_table.Line(x1,y1,x2,y2,clr);
  }
//+------------------------------------------------------------------+
//| Draw all icons of the table                                      |
//+------------------------------------------------------------------+
void CCanvasTable::DrawImages(void)
  {
//--- To calculate the coordinates
   int x=0,y=0;
//--- Columns
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- If the text is not aligned to the left, go to the next column
      if(m_columns[c].m_text_align!=ALIGN_LEFT)
         continue;
      //--- Rows
      for(uint r=m_visible_table_from_index; r<m_visible_table_to_index; r++)
        {
         //--- Go to the next, if this cell does not contain icons
         if(ImagesTotal(c,r)<1)
            continue;
         //--- The selected icon in the cell (the first [0] is selected by default)
         int selected_image=m_columns[c].m_rows[r].m_selected_image;
         //--- Go to the next, if the array of pixels is empty
         if(::ArraySize(m_columns[c].m_rows[r].m_images[selected_image].m_image_data)<1)
            continue;
         //--- Draw icon
         DrawImage(c,r);
        }
     }
  }
//+------------------------------------------------------------------+
//| Draw an icon in the specified cell                               |
//+------------------------------------------------------------------+
void CCanvasTable::DrawImage(const int column_index,const int row_index)
  {
//--- Calculating coordinates
   int x =m_columns[column_index].m_x+m_columns[column_index].m_image_x_offset;
   int y =m_rows[row_index].m_y+m_columns[column_index].m_image_y_offset;
//--- The icon selected in the cell and its size
   int  selected_image =m_columns[column_index].m_rows[row_index].m_selected_image;
   uint image_height   =m_columns[column_index].m_rows[row_index].m_images[selected_image].m_image_height;
   uint image_width    =m_columns[column_index].m_rows[row_index].m_images[selected_image].m_image_width;
//--- Draw
   for(uint ly=0,i=0; ly<image_height; ly++)
     {
      for(uint lx=0; lx<image_width; lx++,i++)
        {
         //--- If there is no color, go to the next pixel
         if(m_columns[column_index].m_rows[row_index].m_images[selected_image].m_image_data[i]<1)
            continue;
         //--- Get the color of the lower layer (cell background) and color of the specified pixel of the icon
         uint background  =(row_index==m_selected_item)? m_selected_row_color : m_table.PixelGet(x+lx,y+ly);
         uint pixel_color =m_columns[column_index].m_rows[row_index].m_images[selected_image].m_image_data[i];
         //--- Blend the colors
         uint foreground=::ColorToARGB(m_clr.BlendColors(background,pixel_color));
         //--- Draw the pixel of the overlay icon
         m_table.PixelSet(x+lx,y+ly,foreground);
        }
     }
  }
//+------------------------------------------------------------------+
//| Draw text                                                        |
//+------------------------------------------------------------------+
void CCanvasTable::DrawText(void)
  {
//--- To calculate the coordinates and offsets
   int  x=0,y=0;
   uint text_align=0;
//--- Font properties
   m_table.FontSet(CElementBase::Font(),-CElementBase::FontSize()*inpFontSize,FW_NORMAL);
//--- Columns
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Get the X coordinate of the text
      x=TextX(c);
      //--- Get the text alignment mode
      text_align=TextAlign(c,TA_TOP);
      //--- Rows
      for(uint r=m_visible_table_from_index; r<m_visible_table_to_index; r++)
        {
         //--- Calculate the Y coordinate
         y=m_rows[r].m_y+m_text_y_offset;
         //--- Draw text
         m_table.TextOut(x,y,Text(c,r),TextColor(c,r),text_align);
        }
      //--- Zero the Y coordinate for the next cycle
      y=0;
     }
  }
//+------------------------------------------------------------------+
//| Draws the table headers                                          |
//+------------------------------------------------------------------+
void CCanvasTable::DrawTableHeaders(void)
  {
//--- Draw headers
   DrawHeaders();
//--- Draw grid
   DrawHeadersGrid();
//--- Draw the text of headers
   DrawHeadersText();
//--- Draw the sign of the possibility of sorting the table
   DrawSignSortedData();
  }
//+------------------------------------------------------------------+
//| Draws the background of headers                                  |
//+------------------------------------------------------------------+
void CCanvasTable::DrawHeaders(void)
  {
//--- If not in focus, reset the header colors
   if(!m_headers.MouseFocus() && m_column_resize_control==WRONG_VALUE)
     {
      m_headers.Erase(::ColorToARGB(m_headers_color));
      return;
     }
//--- To check the focus on the headers
   bool is_header_focus=false;
//--- Coordinates of the mouse cursor
   int x=0;
//--- Coordinates
   int y1=0,y2=m_header_y_size;
//--- Get the relative X coordinate below the mouse cursor
   if(::CheckPointer(m_mouse)!=POINTER_INVALID)
      x=m_mouse.RelativeX(m_headers);
//--- Clear the background of headers
   m_headers.Erase(::ColorToARGB(clrNONE,0));
//--- Offset considering the mode of changing the column widths
   int sep_x_offset=(m_column_resize_mode)? m_sep_x_offset : 0;
//--- Draw the background of headers
   for(uint i=0; i<m_columns_total; i++)
     {
      //--- Check the focus
      if(is_header_focus=x>m_columns[i].m_x+((i!=0)? sep_x_offset : 0) && x<=m_columns[i].m_x2+sep_x_offset)
         m_prev_header_index_focus=(int)i;
      //--- Determine the header color
      uint clr=(i==m_column_resize_control)? ::ColorToARGB(m_headers_color_hover) : HeaderColorCurrent(is_header_focus);
      //--- Draw the header background
      m_headers.FillRectangle(m_columns[i].m_x,y1,m_columns[i].m_x2,y2,clr);
     }
  }
//+------------------------------------------------------------------+
//| Draws the grid of the table headers                              |
//+------------------------------------------------------------------+
void CCanvasTable::DrawHeadersGrid(void)
  {
//--- Grid color
   uint clr=::ColorToARGB(m_grid_color);
//--- Coordinates
   int x1=0,x2=0,y1=0,y2=0;
   x2=m_table_x_size-1;
   y2=m_header_y_size-1;
//--- Draw frame
   m_headers.Rectangle(x1,y1,x2,y2,clr);
//--- Separation lines
   x2=x1=m_columns[0].m_width;
   for(uint i=1; i<m_columns_total; i++)
      m_headers.Line(m_columns[i].m_x,y1,m_columns[i].m_x,y2,clr);
  }
//+------------------------------------------------------------------+
//| Draws the sign of the possibility of sorting the table           |
//+------------------------------------------------------------------+
void CCanvasTable::DrawSignSortedData(void)
  {
//--- Leave, if (1) sorting is disabled or (2) has not been performed yet
   if(!m_is_sort_mode || m_is_sorted_column_index==WRONG_VALUE)
      return;
//--- Calculating coordinates
   int x =m_columns[m_is_sorted_column_index].m_x2-m_sort_arrow_x_gap;
   int y =m_sort_arrow_y_gap;
//--- The selected icon for the sorting direction
   int image_index=(m_last_sort_direction==SORT_ASCEND)? 0 : 1;
//--- Draw
   for(uint ly=0,i=0; ly<m_sort_arrows[image_index].m_image_height; ly++)
     {
      for(uint lx=0; lx<m_sort_arrows[image_index].m_image_width; lx++,i++)
        {
         //--- If there is no color, go to the next pixel
         if(m_sort_arrows[image_index].m_image_data[i]<1)
            continue;
         //--- Get the color of the lower layer (header background) and color of the specified pixel of the icon
         uint background  =m_headers.PixelGet(x+lx,y+ly);
         uint pixel_color =m_sort_arrows[image_index].m_image_data[i];
         //--- Blend the colors
         uint foreground=::ColorToARGB(m_clr.BlendColors(background,pixel_color));
         //--- Draw the pixel of the overlay icon
         m_headers.PixelSet(x+lx,y+ly,foreground);
        }
     }
  }
//+------------------------------------------------------------------+
//| Draws the text of the table headers                              |
//+------------------------------------------------------------------+
void CCanvasTable::DrawHeadersText(void)
  {
//--- To calculate the coordinates and offsets
   int x=0,y=m_header_y_size/2;
   int column_offset =0;
   uint text_align   =0;
//--- Text color
   uint clr=::ColorToARGB(m_headers_text_color);
//--- Font properties
   m_headers.FontSet(CElementBase::Font(),-CElementBase::FontSize()*inpFontSize,FW_NORMAL);
//--- Draw text
   for(uint c=0; c<m_columns_total; c++)
     {
      //--- Get the X coordinate of the text
      x=TextX(c,true);
      //--- Get the text alignment mode
      text_align=TextAlign(c,TA_VCENTER);
      //--- Draw the column name
      m_headers.TextOut(x,y,CorrectingText(c,0,true),clr,text_align);
     }
  }
//+------------------------------------------------------------------+
//| Change the color of the table objects                            |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeObjectsColor(void)
  {
//--- Track the change of color only (1) if the form is not blocked or 
//    (2) not in the mode of changing the column width
   if(m_wnd.IsLocked() || m_column_resize_control!=WRONG_VALUE)
      return;
//--- Changing the color of the headers
   ChangeHeadersColor();
//--- Change the color of rows when hovered
   ChangeRowsColor();
  }
//+------------------------------------------------------------------+
//| Changing the table header color when hovered by mouse cursor     |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeHeadersColor(void)
  {
//--- Leave, if the headers are disabled
   if(!m_show_headers)
      return;
//--- If the cursor is activated
   if(m_column_resize.IsVisible() && m_mouse.LeftButtonState())
     {
      //--- Store the index of the dragged column
      if(m_column_resize_control==WRONG_VALUE)
         m_column_resize_control=m_prev_header_index_focus;
      //---
      return;
     }
//--- If not in focus
   if(!m_headers.MouseFocus())
     {
      //--- If not yet indicated that not in focus
      if(m_prev_header_index_focus!=WRONG_VALUE)
        {
         //--- Reset the focus
         m_prev_header_index_focus=WRONG_VALUE;
         //--- Change the color
         DrawTableHeaders();
         m_headers.Update();
        }
     }
//--- If in focus
   else
     {
      //--- Check the focus on the headers
      CheckHeaderFocus();
      //--- If there is no focus
      if(m_prev_header_index_focus==WRONG_VALUE)
        {
         //--- Change the color
         DrawTableHeaders();
         m_headers.Update();
        }
     }
  }
//+------------------------------------------------------------------+
//| Change the color of rows when hovered                            |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeRowsColor(void)
  {
//--- Leave, if row highlighting when hovered is disabled
   if(!m_lights_hover)
      return;
//--- If not in focus
   if(!m_table.MouseFocus())
     {
      //--- If not yet indicated that not in focus
      if(m_prev_item_index_focus!=WRONG_VALUE)
        {
         m_item_index_focus=WRONG_VALUE;
         //--- Change the color
         RedrawRow();
         m_table.Update();
         //--- Reset the focus
         m_prev_item_index_focus=WRONG_VALUE;
        }
     }
//--- If in focus
   else
     {
      //--- Check the focus on the rows
      if(m_item_index_focus==WRONG_VALUE)
        {
         //--- Get the index of the row with the focus
         m_item_index_focus=CheckRowFocus();
         //--- Change the row color
         RedrawRow();
         m_table.Update();
         //--- Store as the previous index in focus
         m_prev_item_index_focus=m_item_index_focus;
         return;
        }
      //--- Get the relative Y coordinate below the mouse cursor
      int y=m_mouse.RelativeY(m_table);
      //--- Verifying the focus
      bool condition=(y>m_rows[m_item_index_focus].m_y && y<=m_rows[m_item_index_focus].m_y2);
      //--- If the focus changed
      if(!condition)
        {
         //--- Get the index of the row with the focus
         m_item_index_focus=CheckRowFocus();
         //--- Change the row color
         RedrawRow();
         m_table.Update();
         //--- Store as the previous index in focus
         m_prev_item_index_focus=m_item_index_focus;
        }
     }
  }
//+------------------------------------------------------------------+
//| Checking the focus on the header                                 |
//+------------------------------------------------------------------+
void CCanvasTable::CheckHeaderFocus(void)
  {
//--- Leave, if (1) the headers are disabled or (2) changing the column width has started
   if(!m_show_headers || m_column_resize_control!=WRONG_VALUE)
      return;
//--- Get the relative X coordinate below the mouse cursor
   int x=m_mouse.RelativeX(m_headers);
//--- Offset considering the mode of changing the column widths
   int sep_x_offset=(m_column_resize_mode)? m_sep_x_offset : 0;
//--- Search for focus
   for(uint i=0; i<m_columns_total; i++)
     {
      //--- If the header focus has changed
      if((x>m_columns[i].m_x+sep_x_offset && x<=m_columns[i].m_x2+sep_x_offset) && m_prev_header_index_focus!=i)
        {
         m_prev_header_index_focus=WRONG_VALUE;
         break;
        }
     }
  }
//+------------------------------------------------------------------+
//| Determining the indexes of the visible part of the table         |
//+------------------------------------------------------------------+
void CCanvasTable::VisibleTableIndexes(void)
  {
//--- Determine the boundaries taking the offset of the visible part of the table into account
   int yoffset1 =(int)m_table.GetInteger(OBJPROP_YOFFSET);
   int yoffset2 =yoffset1+m_table_visible_y_size;
//--- Determine the first and the last indexes of the visible part of the table
   m_visible_table_from_index =int(double(yoffset1/m_cell_y_size));
   m_visible_table_to_index   =int(double(yoffset2/m_cell_y_size));
//--- Increase the lower index by one, if not out of range
   m_visible_table_to_index=(m_visible_table_to_index+1>m_rows_total)? m_rows_total : m_visible_table_to_index+1;
  }
//+------------------------------------------------------------------+
//| Checking the focus on the table rows                               |
//+------------------------------------------------------------------+
int CCanvasTable::CheckRowFocus(void)
  {
   int item_index_focus=WRONG_VALUE;
//--- Get the relative Y coordinate below the mouse cursor
   int y=m_mouse.RelativeY(m_table);
///--- Get the indexes of the local area of the table
   VisibleTableIndexes();
//--- Search for focus
   for(uint i=m_visible_table_from_index; i<m_visible_table_to_index; i++)
     {
      //--- If the row focus changed
      if(y>m_rows[i].m_y && y<=m_rows[i].m_y2)
        {
         item_index_focus=(int)i;
         break;
        }
     }
//--- Return the index of the row with the focus
   return(item_index_focus);
  }
//+------------------------------------------------------------------+
//| Checking the focus on borders of headers to change their widths  |
//+------------------------------------------------------------------+
void CCanvasTable::CheckColumnResizeFocus(void)
  {
//--- Leave, if the mode of changing the column widths is disabled
   if(!m_column_resize_mode)
      return;
//--- Leave, if started changing the column width
   if(m_column_resize_control!=WRONG_VALUE)
     {
      //--- Update the cursor coordinates and make it visible
      m_column_resize.Moving(m_mouse.X(),m_mouse.Y());
      return;
     }
//--- To check the focus on the borders of headers
   bool is_focus=false;
//--- If the mouse cursor is in the area of headers
   if(m_headers.MouseFocus())
     {
      //--- Get the relative X coordinate below the mouse cursor    
      int x=m_mouse.RelativeX(m_headers);
      //--- Search for focus
      for(uint i=0; i<m_columns_total; i++)
        {
         //--- Verifying the focus
         if(is_focus=x>m_columns[i].m_x2-m_sep_x_offset && x<=m_columns[i].m_x2+m_sep_x_offset)
            break;
        }
      //--- If there is a focus
      if(is_focus)
        {
         //--- Update the cursor coordinates and make it visible
         m_column_resize.Moving(m_mouse.X(),m_mouse.Y());
         //--- Show the cursor
         m_column_resize.Show();
         return;
        }
     }
//--- Hide the pointer, if not in focus
   if(!m_headers.MouseFocus() || !is_focus)
      m_column_resize.Hide();
  }
//+------------------------------------------------------------------+
//| Changes the width of the dragged column                          |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeColumnWidth(void)
  {
//--- Leave, if the headers are disabled
   if(!m_show_headers || m_wnd.IsLocked())
      return;
//--- Check the focus on the header borders
   CheckColumnResizeFocus();
//--- Auxiliary variables
   static int x_fixed    =0;
   static int prev_width =0;
//--- If completed, reset the value
   if(m_column_resize_control==WRONG_VALUE)
     {
      x_fixed    =0;
      prev_width =0;
      return;
     }
//--- Get the relative X coordinate below the mouse cursor
   int x=m_mouse.RelativeX(m_headers);
//--- If the process of changing the column width has just begun
   if(x_fixed<1)
     {
      //--- Store the current X coordinate and width of the column
      x_fixed    =x;
      prev_width =m_columns[m_column_resize_control].m_width;
     }
//--- Calculate the new width for the column
   int new_width=prev_width+(x-x_fixed);
//--- Leave unchanged, if less than the specified limit
   if(new_width<m_min_column_width)
      return;
//--- Save the new width of the column
   m_columns[m_column_resize_control].m_width=new_width;
//--- Calculate the table sizes
   CalculateTableSize();
//--- Resize the table
   ChangeTableSize();
//--- Draw the table
   DrawTable(true);
  }
//+------------------------------------------------------------------+
//| Checking for exceeding the range of columns                      |
//+------------------------------------------------------------------+
template<typename T>
int CCanvasTable::CheckArraySize(const T &array[])
  {
   int total=0;
   int array_size=::ArraySize(array);
//--- Leave, if a zero-sized array was passed
   if(array_size<1)
      return(WRONG_VALUE);
//--- Adjust the value to prevent the array exceeding the range 
   total=(array_size<(int)m_columns_total)? array_size :(int)m_columns_total;
//--- Return the adjusted size of the array
   return(total);
  }
//+------------------------------------------------------------------+
//| Checking for exceeding the range of columns                      |
//+------------------------------------------------------------------+
bool CCanvasTable::CheckOutOfColumnRange(const uint column_index)
  {
//--- Checking for exceeding the column range
   uint csize=::ArraySize(m_columns);
   if(csize<1 || column_index>=csize)
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Checking for exceeding the range of columns and rows             |
//+------------------------------------------------------------------+
bool CCanvasTable::CheckOutOfRange(const uint column_index,const uint row_index)
  {
//--- Checking for exceeding the column range
   uint csize=::ArraySize(m_columns);
   if(csize<1 || column_index>=csize)
      return(false);
//--- Checking for exceeding the row range
   uint rsize=::ArraySize(m_columns[column_index].m_rows);
   if(rsize<1 || row_index>=rsize)
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Calculate with consideration of recent changes and resize table  |
//+------------------------------------------------------------------+
void CCanvasTable::RecalculateAndResizeTable(const bool redraw=false)
  {
//--- Calculate the table sizes
   CalculateTableSize();
//--- Resize the table
   ChangeTableSize();
//--- Update the table
   UpdateTable(redraw);
  }
//+------------------------------------------------------------------+
//| Initialize the specified column with the default values          |
//+------------------------------------------------------------------+
void CCanvasTable::ColumnInitialize(const uint column_index)
  {
//--- Initialize the column properties with the default values
   m_columns[column_index].m_x              =0;
   m_columns[column_index].m_x2             =0;
   m_columns[column_index].m_width          =100;
   m_columns[column_index].m_type           =TYPE_STRING;
   m_columns[column_index].m_text_align     =ALIGN_CENTER;
   m_columns[column_index].m_text_x_offset  =m_text_x_offset;
   m_columns[column_index].m_image_x_offset =m_image_x_offset;
   m_columns[column_index].m_image_y_offset =m_image_y_offset;
   m_columns[column_index].m_header_text    ="";
  }
//+------------------------------------------------------------------+
//| Initialize the specified cell with the default values            |
//+------------------------------------------------------------------+
void CCanvasTable::CellInitialize(const uint column_index,const uint row_index)
  {
   m_columns[column_index].m_rows[row_index].m_full_text      ="";
   m_columns[column_index].m_rows[row_index].m_short_text     ="";
   m_columns[column_index].m_rows[row_index].m_selected_image =0;
   m_columns[column_index].m_rows[row_index].m_text_color     =m_cell_text_color;
   m_columns[column_index].m_rows[row_index].m_digits         =0;
   m_columns[column_index].m_rows[row_index].m_type           =CELL_SIMPLE;
//--- By default, the cells do not contain images
   ::ArrayFree(m_columns[column_index].m_rows[row_index].m_images);
  }
//+------------------------------------------------------------------+
//| Makes a copy of specified column (source) to new location (dest.)|
//+------------------------------------------------------------------+
void CCanvasTable::ColumnCopy(const uint destination,const uint source)
  {
   m_columns[destination].m_header_text    =m_columns[source].m_header_text;
   m_columns[destination].m_width          =m_columns[source].m_width;
   m_columns[destination].m_type           =m_columns[source].m_type;
   m_columns[destination].m_text_align     =m_columns[source].m_text_align;
   m_columns[destination].m_text_x_offset  =m_columns[source].m_text_x_offset;
   m_columns[destination].m_image_x_offset =m_columns[source].m_image_x_offset;
   m_columns[destination].m_image_y_offset =m_columns[source].m_image_y_offset;
  }
//+------------------------------------------------------------------+
//| Makes a copy of specified cell (source) to new location (dest.)  |
//+------------------------------------------------------------------+
void CCanvasTable::CellCopy(const uint column_dest,const uint row_dest,const uint column_source,const uint row_source)
  {
   m_columns[column_dest].m_rows[row_dest].m_type           =m_columns[column_source].m_rows[row_source].m_type;
   m_columns[column_dest].m_rows[row_dest].m_digits         =m_columns[column_source].m_rows[row_source].m_digits;
   m_columns[column_dest].m_rows[row_dest].m_full_text      =m_columns[column_source].m_rows[row_source].m_full_text;
   m_columns[column_dest].m_rows[row_dest].m_short_text     =m_columns[column_source].m_rows[row_source].m_short_text;
   m_columns[column_dest].m_rows[row_dest].m_text_color     =m_columns[column_source].m_rows[row_source].m_text_color;
   m_columns[column_dest].m_rows[row_dest].m_selected_image =m_columns[column_source].m_rows[row_source].m_selected_image;
//--- Copy the array size from the source to receiver
   int images_total=::ArraySize(m_columns[column_source].m_rows[row_source].m_images);
   ::ArrayResize(m_columns[column_dest].m_rows[row_dest].m_images,images_total);
//---
   for(int i=0; i<images_total; i++)
     {
      //--- Copy, if there are images
      if(::ArraySize(m_columns[column_source].m_rows[row_source].m_images[i].m_image_data)<1)
         continue;
      //--- make a copy of the image
      ImageCopy(m_columns[column_dest].m_rows[row_dest].m_images,m_columns[column_source].m_rows[row_source].m_images,i);
     }
  }
//+------------------------------------------------------------------+
//| Copies the image data from one array to another                  |
//+------------------------------------------------------------------+
void CCanvasTable::ImageCopy(CTImage &destination[],CTImage &source[],const int index)
  {
//--- Copy the image pixels
   ::ArrayCopy(destination[index].m_image_data,source[index].m_image_data);
//--- Copy the image properties
   destination[index].m_image_width  =source[index].m_image_width;
   destination[index].m_image_height =source[index].m_image_height;
   destination[index].m_bmp_path     =source[index].m_bmp_path;
  }
//+------------------------------------------------------------------+
//| Returns the text                                                 |
//+------------------------------------------------------------------+
string CCanvasTable::Text(const int column_index,const int row_index)
  {
   string text="";
//--- Adjust the text, if not in the mode of changing the column width
   if(m_column_resize_control==WRONG_VALUE)
      text=CorrectingText(column_index,row_index);
//--- If in the mode of changing the column width, then...
   else
     {
      //--- ...adjust the text only for the column with the width being changed
      if(column_index==m_column_resize_control)
         text=CorrectingText(column_index,row_index);
      //--- For all others, use the previously adjusted text
      else
         text=m_columns[column_index].m_rows[row_index].m_short_text;
     }
//--- Return the text
   return(text);
  }
//+------------------------------------------------------------------+
//| Returns the X coordinate of the text in the specified column     |
//+------------------------------------------------------------------+
int CCanvasTable::TextX(const int column_index,const bool headers=false)
  {
   int x=0;
//--- Text alignment in cells based on the mode set for each column
   switch(m_columns[column_index].m_text_align)
     {
      //--- Center
      case ALIGN_CENTER :
         x=m_columns[column_index].m_x+(m_columns[column_index].m_width/2);
         break;
         //--- Right
      case ALIGN_RIGHT :
        {
         int x_offset=0;
         //---
         if(headers)
            x_offset=(m_is_sorted_column_index!=WRONG_VALUE && m_is_sorted_column_index==column_index)? m_text_x_offset+m_sort_arrow_x_gap : m_text_x_offset;
         else
            x_offset=m_columns[column_index].m_text_x_offset;
         //---
         x=m_columns[column_index].m_x2-x_offset;
         break;
        }
      //--- Left
      case ALIGN_LEFT :
         x=m_columns[column_index].m_x+((headers)? m_text_x_offset : m_columns[column_index].m_text_x_offset);
         break;
     }
//--- Return the alignment type
   return(x);
  }
//+------------------------------------------------------------------+
//| Returns the text alignment mode in the specified column          |
//+------------------------------------------------------------------+
uint CCanvasTable::TextAlign(const int column_index,const uint anchor)
  {
   uint text_align=0;
//--- Text alignment for the current column
   switch(m_columns[column_index].m_text_align)
     {
      case ALIGN_CENTER :
         text_align=TA_CENTER|anchor;
         break;
      case ALIGN_RIGHT :
         text_align=TA_RIGHT|anchor;
         break;
      case ALIGN_LEFT :
         text_align=TA_LEFT|anchor;
         break;
     }
//--- Return the alignment type
   return(text_align);
  }
//+------------------------------------------------------------------+
//| Returns the color of the cell text                               |
//+------------------------------------------------------------------+
uint CCanvasTable::TextColor(const int column_index,const int row_index)
  {
   uint clr=::ColorToARGB((row_index==m_selected_item)? m_selected_row_text_color : m_columns[column_index].m_rows[row_index].m_text_color);
//--- Return the header color
   return(clr);
  }
//+------------------------------------------------------------------+
//| Returns the current header background color                      |
//+------------------------------------------------------------------+
uint CCanvasTable::HeaderColorCurrent(const bool is_header_focus)
  {
   uint clr=clrNONE;
//--- If there is no focus
   if(!is_header_focus || !m_headers.MouseFocus())
      clr=m_headers_color;
   else
     {
      //--- If the left mouse button is pressed and not in the process of changing the column width
      bool condition=(m_mouse.LeftButtonState() && m_column_resize_control==WRONG_VALUE);
      clr=(condition)? m_headers_color_pressed : m_headers_color_hover;
     }
//--- Return the header color
   return(::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| Returns the current row background color                         |
//+------------------------------------------------------------------+
uint CCanvasTable::RowColorCurrent(const int row_index,const bool is_row_focus)
  {
//--- If the row is selected
   if(row_index==m_selected_item)
      return(::ColorToARGB(m_selected_row_color));
//--- Row height
   uint clr=m_cell_color;
//--- If (1) there is no focus or (2) in the process of changing the column width or (3) the form is locked
   bool condition=(!is_row_focus || !m_table.MouseFocus() || m_column_resize_control!=WRONG_VALUE || m_wnd.IsLocked());
//--- If the mode of formatting in Zebra style is enabled
   if(m_is_zebra_format_rows!=clrNONE)
     {
      if(condition)
         clr=(row_index%2!=0)? m_is_zebra_format_rows : m_cell_color;
      else
         clr=m_cell_color_hover;
     }
   else
     {
      clr=(condition)? m_cell_color : m_cell_color_hover;
     }
//--- Return the color
   return(::ColorToARGB(clr));
  }
//+------------------------------------------------------------------+
//| Returns the text adjusted to the column width                    |
//+------------------------------------------------------------------+
string CCanvasTable::CorrectingText(const int column_index,const int row_index,const bool headers=false)
  {
//--- Get the current text
   string corrected_text=(headers)? m_columns[column_index].m_header_text : m_columns[column_index].m_rows[row_index].m_full_text;
//--- Offsets from the cell edges along the X axis
   int x_offset=0;
//---
   if(headers)
      x_offset=(m_is_sorted_column_index==WRONG_VALUE)? m_text_x_offset*2 : m_text_x_offset+m_sort_arrow_x_gap;
   else
      x_offset=m_text_x_offset+m_columns[column_index].m_text_x_offset;
//--- Get the pointer to the canvas object
   CRectCanvas *obj=(headers)? ::GetPointer(m_headers) : ::GetPointer(m_table);
//--- Get the width of the text
   int full_text_width=obj.TextWidth(corrected_text);
//--- If it fits the cell, save the adjusted text in a separate array and return it
   if(full_text_width<=m_columns[column_index].m_width-x_offset)
     {
      //--- If those are not headers, save the adjusted text
      if(!headers)
         m_columns[column_index].m_rows[row_index].m_short_text=corrected_text;
      //---
      return(corrected_text);
     }
//--- If the text does not fit the cell, it is necessary to adjust the text (trim the excessive characters and add an ellipsis)
   else
     {
      //--- For working with a string
      string temp_text="";
      //--- Get the string length
      int total=::StringLen(corrected_text);
      //--- Delete characters from the string one by one, until the desired text width is reached
      for(int i=total-1; i>=0; i--)
        {
         //--- Delete one character
         temp_text=::StringSubstr(corrected_text,0,i);
         //--- If nothing is left, leave an empty string
         if(temp_text=="")
           {
            corrected_text="";
            break;
           }
         //--- Add an ellipsis before checking
         int text_width=obj.TextWidth(temp_text+"...");
         //--- If fits the cell
         if(text_width<m_columns[column_index].m_width-x_offset)
           {
            //--- Save the text and stop the cycle
            corrected_text=temp_text+"...";
            break;
           }
        }
     }
//--- If those are not headers, save the adjusted text
   if(!headers)
      m_columns[column_index].m_rows[row_index].m_short_text=corrected_text;
//--- Return the adjusted text
   return(corrected_text);
  }
//+------------------------------------------------------------------+
//| Moving the element                                               |
//+------------------------------------------------------------------+
void CCanvasTable::Moving(const int x,const int y,const bool moving_mode=false)
  {
//--- Leave, if the control is hidden
   if(!CElementBase::IsVisible())
      return;
//--- If the management is delegated to the window, identify its location
   if(!moving_mode)
      if(!CElement::CheckPressedInsideHeader())
         return;
//--- If the anchored to the right
   if(m_anchor_right_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::X(m_wnd.X2()-XGap());
      //--- Storing coordinates in the fields of the objects
      m_area.X(m_wnd.X2()-m_area.XGap());
      m_table.X(m_wnd.X2()-m_table.XGap());
      m_headers.X(m_wnd.X2()-m_headers.XGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::X(x+XGap());
      //--- Storing coordinates in the fields of the objects
      m_area.X(x+m_area.XGap());
      m_table.X(x+m_table.XGap());
      m_headers.X(x+m_headers.XGap());
     }
//--- If the anchored to the bottom
   if(m_anchor_bottom_window_side)
     {
      //--- Storing coordinates in the element fields
      CElementBase::Y(m_wnd.Y2()-YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(m_wnd.Y2()-m_area.YGap());
      m_table.Y(m_wnd.Y2()-m_table.YGap());
      m_headers.X(m_wnd.Y2()-m_headers.YGap());
     }
   else
     {
      //--- Storing coordinates in the fields of the objects
      CElementBase::Y(y+YGap());
      //--- Storing coordinates in the fields of the objects
      m_area.Y(y+m_area.YGap());
      m_table.Y(y+m_table.YGap());
      m_headers.Y(y+m_headers.YGap());
     }
//--- Updating coordinates of graphical objects
   m_area.X_Distance(m_area.X());
   m_area.Y_Distance(m_area.Y());
   m_table.X_Distance(m_table.X());
   m_table.Y_Distance(m_table.Y());
   m_headers.X_Distance(m_headers.X());
   m_headers.Y_Distance(m_headers.Y());
  }
//+------------------------------------------------------------------+
//| Shows the element                                                |
//+------------------------------------------------------------------+
void CCanvasTable::Show(void)
  {
//--- Leave, if the element is already visible
   if(CElementBase::IsVisible())
      return;
//--- Make all the objects visible
   m_area.Timeframes(OBJ_ALL_PERIODS);
   m_table.Timeframes(OBJ_ALL_PERIODS);
   m_headers.Timeframes(OBJ_ALL_PERIODS);
   m_scrollv.Show();
   m_scrollh.Show();
//--- Visible state
   CElementBase::IsVisible(true);
//--- Moving the element
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Hides the element                                                |
//+------------------------------------------------------------------+
void CCanvasTable::Hide(void)
  {
//--- Leave, if the element is already hidden
   if(!CElementBase::IsVisible())
      return;
//--- Hide all objects
   m_area.Timeframes(OBJ_NO_PERIODS);
   m_table.Timeframes(OBJ_NO_PERIODS);
   m_headers.Timeframes(OBJ_NO_PERIODS);
   m_scrollv.Hide();
   m_scrollh.Hide();
//--- Visible state
   CElementBase::IsVisible(false);
  }
//+------------------------------------------------------------------+
//| Redrawing                                                        |
//+------------------------------------------------------------------+
void CCanvasTable::Reset(void)
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
void CCanvasTable::Delete(void)
  {
//--- Delete graphical objects
   m_area.Delete();
   m_table.Delete();
   m_headers.Delete();
   m_column_resize.Delete();
//--- Emptying the control arrays
   for(uint c=0; c<m_columns_total; c++)
     {
      for(uint r=0; r<m_rows_total; r++)
        {
         for(int i=0; i<ImagesTotal(c,r); i++)
            ::ArrayFree(m_columns[c].m_rows[r].m_images[i].m_image_data);
         //---
         ::ArrayFree(m_columns[c].m_rows[r].m_images);
        }
     }
   for(uint c=0; c<m_columns_total; c++)
      ::ArrayFree(m_columns[c].m_rows);
//---
   ::ArrayFree(m_rows);
   ::ArrayFree(m_columns);
//--- Emptying the array of the objects
   CElementBase::FreeObjectsArray();
//--- Initializing of variables by default values
   CElementBase::IsVisible(true);
   m_is_sorted_column_index=WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Seth the priorities                                              |
//+------------------------------------------------------------------+
void CCanvasTable::SetZorders(void)
  {
   m_area.Z_Order(m_zorder);
   m_headers.Z_Order(m_cell_zorder);
   m_table.Z_Order(m_cell_zorder);
   m_scrollv.SetZorders();
   m_scrollh.SetZorders();
  }
//+------------------------------------------------------------------+
//| Reset the priorities                                             |
//+------------------------------------------------------------------+
void CCanvasTable::ResetZorders(void)
  {
   m_area.Z_Order(0);
   m_headers.Z_Order(0);
   m_table.Z_Order(0);
   m_scrollv.ResetZorders();
   m_scrollh.ResetZorders();
  }
//+------------------------------------------------------------------+
//| Fast forward of the scrollbar                                    |
//+------------------------------------------------------------------+
void CCanvasTable::FastSwitching(void)
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
      //--- Shift the table
      ShiftTable();
     }
  }
//+------------------------------------------------------------------+
//| Calculate the size of the table                                  |
//+------------------------------------------------------------------+
void CCanvasTable::CalculateTableSize(void)
  {
//--- Calculate the total width of the table
   m_table_x_size=0;
   for(uint c=0; c<m_columns_total; c++)
      m_table_x_size=m_table_x_size+m_columns[c].m_width;
//--- Width of the table with a vertical scrollbar
   int x_size=(m_table_y_size>m_table_visible_y_size) ? m_x_size-m_scrollh.ScrollWidth()-1 : m_x_size-2;
//--- Set the frame width to display a fragment of the image (visible part of the table)
   m_table_visible_x_size=x_size;
//--- Adjust the size of the visible area along the X axis
   m_table_visible_x_size=(m_table_visible_x_size>=m_table_x_size)? m_table_x_size : m_table_visible_x_size;
//--- Calculate the total height of the table
   m_table_y_size=(int)(m_cell_y_size*m_rows_total)+2;
//--- If there is a horizontal scrollbar, adjust the control size along the Y axis
   int header_y_size=(m_show_headers)? m_header_y_size : 2;
   int y_size=(m_table_x_size>m_table_visible_x_size) ? m_y_size-header_y_size-m_scrollv.ScrollWidth()+1 : m_y_size-header_y_size;
//--- Set the frame height to display a fragment of the image (visible part of the table)
   m_table_visible_y_size=y_size;
//--- Adjust the size of the visible area along the Y axis
   m_table_visible_y_size=(m_table_visible_y_size>=m_table_y_size)? m_table_y_size : m_table_visible_y_size;
//--- Check for presence of a horizontal scrollbar
   bool is_scrollh=m_table_x_size>m_table_visible_x_size;
   bool is_scrollv=m_table_y_size>m_table_visible_y_size;
//--- Adjusting sizes relative to the presence of scrollbars
   if(!is_scrollv)
     {
      x_size=m_table_visible_x_size+m_scrollv.ScrollWidth()-1;
      if(x_size<m_area.XSize() && (x_size<m_table_x_size || m_table_x_size<m_area.XSize()))
         m_table_visible_x_size=(x_size>m_table_x_size)? m_table_x_size : x_size;
     }
   else
     {
      //--- If there is a horizontal scrollbar
      if(is_scrollh)
         m_table_visible_x_size=m_x_size-m_scrollv.ScrollWidth()-1;
      //--- If there is no horizontal scrollbar
      else
        {
         x_size=m_x_size-m_scrollv.ScrollWidth();
         if(x_size<m_table_x_size)
           {
            is_scrollh=true;
            m_table_visible_x_size =x_size-1;
            m_table_visible_y_size =m_y_size-m_scrollv.ScrollWidth();
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Change the main size of the table                                |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeMainSize(const int x_size,const int y_size)
  {
//--- Set the new size to the table background
   CElementBase::XSize(x_size);
   m_area.XSize(x_size);
   m_area.X_Size(x_size);
   CElementBase::YSize(y_size);
   m_area.YSize(y_size);
   m_area.Y_Size(y_size);
  }
//+------------------------------------------------------------------+
//| Resize the table                                                 |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeTableSize(void)
  {
//--- Resize the table
   m_table.XSize(m_table_visible_x_size);
   m_table.YSize(m_table_visible_y_size);
   m_headers.XSize(m_table_visible_x_size);
   m_headers.YSize(m_header_y_size);
   m_table.Resize(m_table_x_size,m_table_y_size);
   m_headers.Resize(m_table_x_size,m_header_y_size);
//--- Set the size of the visible area
   m_table.SetInteger(OBJPROP_XSIZE,m_table_visible_x_size);
   m_table.SetInteger(OBJPROP_YSIZE,m_table_visible_y_size);
   m_headers.SetInteger(OBJPROP_XSIZE,m_table_visible_x_size);
   m_headers.SetInteger(OBJPROP_YSIZE,m_header_y_size);
//--- Resize the scrollbars
   ChangeScrollsSize();
//--- Adjust the data
   ShiftTable();
  }
//+------------------------------------------------------------------+
//| Resize the scrollbars                                            |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeScrollsSize(void)
  {
//--- Check for presence of a scrollbar
   bool is_scrollh=m_table_x_size>m_table_visible_x_size;
   bool is_scrollv=m_table_y_size>m_table_visible_y_size;
//--- Calculate the sizes of the scrollbars
   m_scrollh.Reinit(m_table_x_size,m_table_visible_x_size);
   m_scrollv.Reinit(m_table_y_size,m_table_visible_y_size);
//--- If the horizontal scrollbar is not required
   if(!is_scrollh)
     {
      //--- Hide the horizontal scrollbar
      m_scrollh.Hide();
      //--- Change the height of the vertical scrollbar
      m_scrollv.ChangeYSize(CElementBase::YSize());
     }
   else
     {
      //--- Show the horizontal scrollbar
      if(CElementBase::IsVisible())
         m_scrollh.Show();
      //--- Calculate and change the height of the vertical scrollbar
      m_scrollv.ChangeYSize(CElementBase::YSize()-m_scrollh.ScrollWidth()+1);
     }
//--- If the vertical scrollbar is not required
   if(!is_scrollv)
     {
      //--- Hide the vertical scrollbar
      m_scrollv.Hide();
      //--- Change the width of the horizontal scrollbar
      m_scrollh.ChangeXSize(CElementBase::XSize());
     }
   else
     {
      //--- Show the vertical scrollbar
      if(CElementBase::IsVisible())
         m_scrollv.Show();
      //--- Calculate and change the width of the horizontal scrollbar
      m_scrollh.ChangeXSize(CElementBase::XSize()-m_scrollv.ScrollWidth()+1);
     }
  }
//+------------------------------------------------------------------+
//| Change the width at the right edge of the form                   |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeWidthByRightWindowSide(void)
  {
//--- Leave, if the anchoring mode to the right side of the form is enabled
   if(m_anchor_right_window_side)
      return;
//--- Sizes
   int x_size=m_wnd.X2()-m_area.X()-m_auto_xresize_right_offset;
   int y_size=(m_auto_yresize_mode)? m_wnd.Y2()-m_area.Y()-m_auto_yresize_bottom_offset : m_y_size;
//--- Leave, if the size is less than specified
   if(x_size<100)
      return;
//--- Set the new size of the table background
   ChangeMainSize(x_size,y_size);
//--- Calculate the table sizes
   CalculateTableSize();
//--- Calculate and set the new coordinate for the vertical scrollbar
   int x=m_area.X2()-m_scrollv.ScrollWidth();
   m_scrollv.XDistance(x);
//--- Resize the table
   ChangeTableSize();
//--- Draw the table
   DrawTable();
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
//| Change the height at the bottom edge of the window               |
//+------------------------------------------------------------------+
void CCanvasTable::ChangeHeightByBottomWindowSide(void)
  {
//--- Leave, if the anchoring mode to the bottom of the form is enabled  
   if(m_anchor_bottom_window_side)
      return;
//--- Sizes
   int x_size=(m_auto_xresize_mode)? m_wnd.X2()-m_area.X()-m_auto_xresize_right_offset : m_x_size;
   int y_size=m_wnd.Y2()-m_area.Y()-m_auto_yresize_bottom_offset;
//--- Leave, if the size is less than specified
   if(y_size<60)
      return;
//--- Set the new size of the table background
   ChangeMainSize(x_size,y_size);
//--- Calculate the table sizes
   CalculateTableSize();
//--- Calculate and set the new coordinate for the horizontal scrollbar
   int y=m_area.Y2()-m_scrollh.ScrollWidth();
   m_scrollh.YDistance(y);
//--- Resize the table
   ChangeTableSize();
//--- Draw the table
   DrawTable();
//--- Update the position of objects
   Moving(m_wnd.X(),m_wnd.Y(),true);
  }
//+------------------------------------------------------------------+
