//+------------------------------------------------------------------+
//|                                               PicturesSlider.mqh |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "..\Element.mqh"
#include "Picture.mqh"
#include "Button.mqh"
#include "ButtonsGroup.mqh"
//--- Картинка по умолчанию
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp64\\no_image.bmp"
//+------------------------------------------------------------------+
//| Класс для создания слайдера картинок                             |
//+------------------------------------------------------------------+
class CPicturesSlider : public CElement
  {
private:
   //--- Объекты для создания элемента
   CPicture          m_pictures[];
   CButtonsGroup     m_radio_buttons;
   CButton           m_left_arrow;
   CButton           m_right_arrow;
   //--- Массив картинок (путь к картинкам)
   string            m_file_path[];
   //--- Путь к картинке по умолчанию
   string            m_default_path;
   //--- Отступ для картинок по оси Y
   int               m_pictures_y_gap;
   //--- Отступы для кнопок
   int               m_arrows_x_gap;
   int               m_arrows_y_gap;
   //--- Ширина радио-кнопки
   int               m_radio_button_width;
   //--- Отступы для радио-кнопок
   int               m_radio_buttons_x_gap;
   int               m_radio_buttons_y_gap;
   int               m_radio_buttons_x_offset;
   //---
public:
                     CPicturesSlider(void);
                    ~CPicturesSlider(void);
   //--- Методы для создания слайдера картинок
   bool              CreatePicturesSlider(const int x_gap,const int y_gap);
   //---
private:
   void              InitializeProperties(const int x_gap,const int y_gap);
   bool              CreateCanvas(void);
   bool              CreatePictures(void);
   bool              CreateRadioButtons(void);
   bool              CreateArrow(CButton &button_obj,const int index);
   //---
public:
   //--- Возвращает указатели на составные элементы
   CButtonsGroup    *GetRadioButtonsPointer(void)            { return(::GetPointer(m_radio_buttons)); }
   CButton          *GetLeftArrowPointer(void)               { return(::GetPointer(m_left_arrow));    }
   CButton          *GetRightArrowPointer(void)              { return(::GetPointer(m_right_arrow));   }
   CPicture         *GetPicturePointer(const uint index);
   //--- Отступы для кнопок-стрелок
   void              ArrowsXGap(const int x_gap)             { m_arrows_x_gap=x_gap;                  }
   void              ArrowsYGap(const int y_gap)             { m_arrows_y_gap=y_gap;                  }
   //--- (1) Возвращает количество картинок, (2) отступ для картинок по оси Y
   int               PicturesTotal(void)               const { return(::ArraySize(m_pictures));       }
   void              PictureYGap(const int y_gap)            { m_pictures_y_gap=y_gap;                }
   //--- (1) Отступы радио-кнопок, (2) расстояние между радио-кнопками
   void              RadioButtonsXGap(const int x_gap)       { m_radio_buttons_x_gap=x_gap;           }
   void              RadioButtonsYGap(const int y_gap)       { m_radio_buttons_y_gap=y_gap;           }
   void              RadioButtonsXOffset(const int x_offset) { m_radio_buttons_x_offset=x_offset;     }
   //--- Добавляет картинку
   void              AddPicture(const string file_path="");
   //--- Переключает картинку по указанному индексу
   void              SelectPicture(const int index);
   //---
public:
   //--- Обработчик событий графика
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //--- Показать, удалить
   virtual void      Show(void);
   virtual void      Delete(void);
   //--- Рисует элемент
   virtual void      Draw(void);
   //---
private:
   //--- Обработка нажатия на радио-кнопку
   bool              OnClickRadioButton(const string clicked_object,const int id,const int index);
   //--- Обработка нажатия на левой кнопку
   bool              OnClickLeftArrow(const string clicked_object,const int id,const int index);
   //--- Обработка нажатия на правой кнопку
   bool              OnClickRightArrow(const string clicked_object,const int id,const int index);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPicturesSlider::CPicturesSlider(void) : m_default_path("Images\\EasyAndFastGUI\\Icons\\bmp64\\no_image.bmp"),
                                         m_arrows_x_gap(2),
                                         m_arrows_y_gap(2),
                                         m_radio_button_width(18),
                                         m_radio_buttons_x_gap(25),
                                         m_radio_buttons_y_gap(1),
                                         m_radio_buttons_x_offset(20),
                                         m_pictures_y_gap(25)
  {
//--- Сохраним имя класса элемента в базовом классе
   CElementBase::ClassName(CLASS_NAME);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPicturesSlider::~CPicturesSlider(void)
  {
  }
//+------------------------------------------------------------------+
//| Обработчик событий                                               |
//+------------------------------------------------------------------+
void CPicturesSlider::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Обработка события нажатия левой кнопки мыши на объекте
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_BUTTON)
     {
      //--- Нажатие на радио-кнопке
      if(OnClickRadioButton(sparam,(int)lparam,(int)dparam))
         return;
      //--- Если нажатие на кнопках-стрелках слайдера, переключить картинку
      if(OnClickLeftArrow(sparam,(int)lparam,(int)dparam))
         return;
      if(OnClickRightArrow(sparam,(int)lparam,(int)dparam))
         return;
      //---
      return;
     }
  }
//+------------------------------------------------------------------+
//| Создаёт элемент                                                  |
//+------------------------------------------------------------------+
bool CPicturesSlider::CreatePicturesSlider(const int x_gap,const int y_gap)
  {
//--- Выйти, если нет указателя на главный элемент
   if(!CElement::CheckMainPointer())
      return(false);
//--- Инициализация свойств
   InitializeProperties(x_gap,y_gap);
//--- Создание элемента
   if(!CreateCanvas())
      return(false);
   if(!CreatePictures())
      return(false);
   if(!CreateRadioButtons())
      return(false);
   if(!CreateArrow(m_left_arrow,0))
      return(false);
   if(!CreateArrow(m_right_arrow,1))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Инициализация свойств                                            |
//+------------------------------------------------------------------+
void CPicturesSlider::InitializeProperties(const int x_gap,const int y_gap)
  {
   m_x      =CElement::CalculateX(x_gap);
   m_y      =CElement::CalculateY(y_gap);
   m_x_size =(m_x_size<1)? 300 : m_x_size;
   m_y_size =(m_y_size<1)? 300 : m_y_size;
//--- Свойства по умолчанию
   m_back_color   =(m_back_color!=clrNONE)? m_back_color : m_main.BackColor();
   m_border_color =(m_border_color!=clrNONE)? m_border_color : m_main.BackColor();
//--- Отступы от крайней точки
   CElementBase::XGap(x_gap);
   CElementBase::YGap(y_gap);
  }
//+------------------------------------------------------------------+
//| Создаёт объект для рисования                                     |
//+------------------------------------------------------------------+
bool CPicturesSlider::CreateCanvas(void)
  {
//--- Формирование имени объекта
   string name=CElementBase::ElementName("pictures_slider");
//--- Создание объекта
   if(!CElement::CreateCanvas(name,m_x,m_y,m_x_size,m_y_size))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт группу картинок                                          |
//+------------------------------------------------------------------+
bool CPicturesSlider::CreatePictures(void)
  {
//--- Получим количество картинок
   int pictures_total=PicturesTotal();
//--- Если нет ни одной картинки в группе, сообщить об этом
   if(pictures_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна картинка! Воспользуйтесь методом CPicturesSlider::AddPicture()");
      return(false);
     }
//--- Координаты
   int x=0,y=m_pictures_y_gap;
//--- Размеры
   uint x_size=0,y_size=0;
//--- Массив для изображения
   uint image_data[];
//---
   for(int i=0; i<pictures_total; i++)
     {
      //--- Сохраним указатель на окно
      m_pictures[i].MainPointer(this);
      //--- Прочитать данные изображения
      if(!::ResourceReadImage("::"+m_file_path[i],image_data,x_size,y_size))
        {
         ::Print(__FUNCTION__," > Ошибка при чтении изображения ("+m_file_path[i]+"): ",::GetLastError());
         return(false);
        }
      //--- Рассчитать отступ
      x=(m_x_size>>1)-(x_size>>1);
      //--- Свойства
      m_pictures[i].Index(i);
      m_pictures[i].XSize(x_size);
      m_pictures[i].YSize(y_size);
      m_pictures[i].NamePart("picture_slider");
      m_pictures[i].IconFile(m_file_path[i]);
      m_pictures[i].IconFileLocked(m_file_path[i]);
      //--- Создание кнопки
      if(!m_pictures[i].CreatePicture(x,y))
         return(false);
      //--- Добавить элемент в массив
      CElement::AddToArray(m_pictures[i]);
     }
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт группу радио-кнопок                                      |
//+------------------------------------------------------------------+
bool CPicturesSlider::CreateRadioButtons(void)
  {
//--- Сохраним указатель на родительский элемент
   m_radio_buttons.MainPointer(this);
//--- Координаты
   int x=m_radio_buttons_x_gap,y=m_radio_buttons_y_gap;
//--- Количество картинок
   int pictures_total=PicturesTotal();
//--- Свойства
   int buttons_x_offset[];
//--- Установим размер массивам
   ::ArrayResize(buttons_x_offset,pictures_total);
//--- Отступы между радио-кнопками
   for(int i=0; i<pictures_total; i++)
      buttons_x_offset[i]=(i>0)? buttons_x_offset[i-1]+m_radio_buttons_x_offset : 0;
//---
   m_radio_buttons.NamePart("radio_button");
   m_radio_buttons.RadioButtonsMode(true);
   m_radio_buttons.RadioButtonsStyle(true);
//--- Добавим кнопки в группу
   for(int i=0; i<pictures_total; i++)
      m_radio_buttons.AddButton(buttons_x_offset[i],0,"",m_radio_button_width);
//--- Создать группу кнопок
   if(!m_radio_buttons.CreateButtonsGroup(x,y))
      return(false);
//--- Покажем картинку по выделенной радио-кнопке
   SelectPicture(1);
//--- Добавить элемент в массив
   CElement::AddToArray(m_radio_buttons);
   return(true);
  }
//+------------------------------------------------------------------+
//| Создаёт кнопку со стрелкой                                       |
//+------------------------------------------------------------------+
//#resource "\\Images\\EasyAndFastGUI\\Controls\\left_thin_black.bmp"
//#resource "\\Images\\EasyAndFastGUI\\Controls\\right_thin_black.bmp"
//---
bool CPicturesSlider::CreateArrow(CButton &button_obj,const int index)
  {
//--- Сохраним указатель на главный элемент
   button_obj.MainPointer(this);
//--- Координаты
   int x =(index<1)? m_arrows_x_gap : m_arrows_x_gap+16;
   int y =m_arrows_y_gap;
//--- Установим свойства перед созданием
   button_obj.Index(index);
   button_obj.XSize(16);
   button_obj.YSize(16);
//--- Ярлыки для кнопок
   if(index<1)
     {
      button_obj.IconFile(RESOURCE_LEFT_THIN_BLACK);
      button_obj.IconFileLocked(RESOURCE_LEFT_THIN_BLACK);
     }
   else
     {
      button_obj.IconFile(RESOURCE_RIGHT_THIN_BLACK);
      button_obj.IconFileLocked(RESOURCE_RIGHT_THIN_BLACK);
      button_obj.AnchorRightWindowSide(true);
     }
//--- Создадим элемент управления
   if(!button_obj.CreateButton("",x,y))
      return(false);
//--- Добавить элемент в массив
   CElement::AddToArray(button_obj);
   return(true);
  }
//+------------------------------------------------------------------+
//| Добавляет картинку                                               |
//+------------------------------------------------------------------+
CPicture *CPicturesSlider::GetPicturePointer(const uint index)
  {
   uint array_size=PicturesTotal();
//--- Проверка размера массива объектов
   if(array_size<1)
     {
      Print(__FUNCTION__," > В группе нет ни одного элемента!");
      return(NULL);
     }
//--- Корректировка в случае выхода из диапазона
   uint i=(index>=array_size)? array_size-1 : index;
//--- Вернуть указатель объекта
   return(::GetPointer(m_pictures[i]));
  }
//+------------------------------------------------------------------+
//| Добавляет картинку                                               |
//+------------------------------------------------------------------+
void CPicturesSlider::AddPicture(const string file_path="")
  {
//--- Увеличим размер массивов на один элемент
   int array_size=::ArraySize(m_pictures);
   int new_size=array_size+1;
   ::ArrayResize(m_pictures,new_size);
   ::ArrayResize(m_file_path,new_size);
//--- Сохраним значения переданных параметров
   m_file_path[array_size]=(file_path=="")? m_default_path : file_path;
  }
//+------------------------------------------------------------------+
//| Указывает, какая картинка должна быть показана                   |
//+------------------------------------------------------------------+
void CPicturesSlider::SelectPicture(const int index)
  {
//--- Получим количество картинок
   int pictures_total=PicturesTotal();
//--- Если нет ни одной картинки в группе, сообщить об этом
   if(pictures_total<1)
     {
      ::Print(__FUNCTION__," > Вызов этого метода нужно осуществлять, "
              "когда в группе есть хотя бы одна картинка! Воспользуйтесь методом CPicturesSlider::AddPicture()");
      return;
     }
//--- Скорректировать значение индекса, если выходит из диапазона
   uint correct_index=(index>=pictures_total)? pictures_total-1 :(index<0)? 0 : index;
//--- Выделить радио-кнопку по этому индексу
   m_radio_buttons.SelectButton(correct_index);
//--- Переключить картинку
   for(int i=0; i<pictures_total; i++)
     {
      if(i==correct_index)
         m_pictures[i].Show();
      else
         m_pictures[i].Hide();
     }
  }
//+------------------------------------------------------------------+
//| Показать                                                         |
//+------------------------------------------------------------------+
void CPicturesSlider::Show(void)
  {
   CElement::Show();
   SelectPicture(m_radio_buttons.SelectedButtonIndex());
  }
//+------------------------------------------------------------------+
//| Удаление                                                         |
//+------------------------------------------------------------------+
void CPicturesSlider::Delete(void)
  {
   CElement::Delete();
//--- Освобождение массивов элемента
   ::ArrayFree(m_pictures);
  }
//+------------------------------------------------------------------+
//| Нажатие на радио-кнопку                                          |
//+------------------------------------------------------------------+
bool CPicturesSlider::OnClickRadioButton(const string clicked_object,const int id,const int index)
  {
//--- Выйдем, если нажатие было не на кнопке
   if(::StringFind(clicked_object,m_radio_buttons.NamePart(),0)<0)
      return(false);
//--- Выйти, если (1) идентификаторы не совпадают или (2) элемент заблокирован
   if(id!=CElementBase::Id() || CElementBase::IsLocked())
      return(false);
//--- Выйти, если индекс совпадает
   if(index==m_radio_buttons.SelectedButtonIndex())
      return(true);
//--- Выбрать картинку
   SelectPicture(index);
//--- Перерисовать элемент
   m_radio_buttons.Update(true);
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на левую кнопку                                          |
//+------------------------------------------------------------------+
bool CPicturesSlider::OnClickLeftArrow(const string clicked_object,const int id,const int index)
  {
//--- Выйдем, если нажатие было не на кнопке
   if(::StringFind(clicked_object,m_left_arrow.NamePart(),0)<0)
      return(false);
//--- Выйти, если (1) идентификаторы не совпадают или (2) элемент заблокирован
   if(id!=CElementBase::Id() || index!=m_left_arrow.Index() || CElementBase::IsLocked())
      return(false);
//--- Получим текущий индекс выделенной радио-кнопки
   int selected_radio_button=m_radio_buttons.SelectedButtonIndex();
//--- Переключение картинки
   SelectPicture(--selected_radio_button);
//--- Перерисовать радио-кнопки
   m_radio_buttons.Update(true);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElementBase::Id(),CElementBase::Index(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Нажатие на правую кнопку                                         |
//+------------------------------------------------------------------+
bool CPicturesSlider::OnClickRightArrow(const string clicked_object,const int id,const int index)
  {
//--- Выйдем, если нажатие было не на кнопке
   if(::StringFind(clicked_object,m_right_arrow.NamePart(),0)<0)
      return(false);
//--- Выйти, если (1) идентификаторы не совпадают или (2) элемент заблокирован
   if(id!=CElementBase::Id() || index!=m_right_arrow.Index() || CElementBase::IsLocked())
      return(false);
//--- Получим текущий индекс выделенной радио-кнопки
   int selected_radio_button=m_radio_buttons.SelectedButtonIndex();
//--- Переключение картинки
   SelectPicture(++selected_radio_button);
//--- Перерисовать радио-кнопки
   m_radio_buttons.Update(true);
//--- Отправим сообщение об этом
   ::EventChartCustom(m_chart_id,ON_CLICK_BUTTON,CElementBase::Id(),CElementBase::Index(),"");
   return(true);
  }
//+------------------------------------------------------------------+
//| Рисует элемент                                                   |
//+------------------------------------------------------------------+
void CPicturesSlider::Draw(void)
  {
//--- Нарисовать фон
   CElement::DrawBackground();
//--- Нарисовать рамку
   CElement::DrawBorder();
  }
//+------------------------------------------------------------------+
