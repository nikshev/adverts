unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, MSHTML_TLB, OleCtrls, SHDocVw,
  xmldom, XMLIntf, msxmldom, XMLDoc,WinInet;

type
  TForm1 = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    lbl1: TLabel;
    mmo1: TMemo;
    lbl2: TLabel;
    mmo2: TMemo;
    wb1: TWebBrowser;
    btn3: TButton;
    btn1: TButton;
    xmldcmnt1: TXMLDocument;
    ts3: TTabSheet;
    lbl3: TLabel;
    mmo3: TMemo;
    lbl4: TLabel;
    wb2: TWebBrowser;
    btn2: TButton;
    btn4: TButton;
    mmo4: TMemo;
    lbl5: TLabel;
    edt1: TEdit;
    lbl6: TLabel;
    edt2: TEdit;
    edt3: TEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    edt4: TEdit;
    lbl9: TLabel;
    edt5: TEdit;
    lbl10: TLabel;
    edt6: TEdit;
    lbl11: TLabel;
    edt7: TEdit;
    lbl12: TLabel;
    edt8: TEdit;
    lbl13: TLabel;
    mmo5: TMemo;
    btn5: TButton;
    lbl14: TLabel;
    edt9: TEdit;
    procedure btn1Click(Sender: TObject); //Кнопка дальше сопоставление полей программы с сайтом
    procedure LoadPage;                   //Загрузка страницы в web браузере при обучении
    procedure LoadPage2;                   //Загрузка страницы в web браузере при подаче объявлений
    procedure LoadPagesFromXML;           //Загрузка доступных сайтов в программу
    procedure btn3Click(Sender: TObject); //Кнопка старта обучения
    procedure FormResize(Sender: TObject); //Изменение размеров формы
    procedure btn2Click(Sender: TObject); //Кнопка старта подачи
    procedure LockFields;                 //Замыкание полей
    procedure UnLockFields;               //Размыкание полей
    procedure FillFields;                 //Заполнение полей
    function  checkData:Boolean;
    procedure btn4Click(Sender: TObject);
    procedure wb2DocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure btn5Click(Sender: TObject);          //Проверка на заполнение полей
    function  FindUrlDuplicate(url:string):boolean;
    procedure wb1DocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);  //Проверка на дубль
    procedure ClearCookies; // Очистка Cookie;
    procedure EndBrowserSession; //Завершение сессии браузера

  private
    { Private declarations }
   oldUrl:string;
  public
    { Public declarations }
  end;

  
var
  Form1: TForm1;
  StopT:Boolean;
  LineIndex:Integer;

implementation

{$R *.dfm}

//Кнопка дальше
procedure TForm1.btn1Click(Sender: TObject);
var
  Document: Variant;
  k, m: Integer;
  ovElements: OleVariant;
  i,j: Integer;
  title:string;
  description:string;
  adress:string;
  price:string;
  contact:string;
  phone:string;
  email:string;
  company:string;
  url:string;
  XML : IXMLDOCUMENT;
  RootNode, ParentNode,ChildNode : IXMLNODE;
  not_rewrite:boolean;
begin
 btn1.Enabled:=False;
 not_rewrite:=False;
  if not FileExists('base.xml') then
   begin
    XML := NewXMLDocument;
    XML.Encoding := 'utf-8';
    XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
    RootNode := XML.AddChild('XML');
   end
  else
   begin
    XML := NewXMLDocument;
    XML.LoadFromFile('base.xml');
    XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
    RootNode := XML.DocumentElement;

    //Защита от двойников
    not_rewrite:=FindUrlDuplicate(wb1.LocationURL);
   end;

 //Достаем из браузера значения полей
 if not not_rewrite then
  begin
   ParentNode:= RootNode.AddChild('Site');
   ParentNode.Attributes['www']:=wb1.LocationURL;

   ovElements:=wb1.OleObject.Document.getelementsbytagname('input');

     // iterate through elements
     for i := 0 to ovElements.Length - 1 do
      begin
       // when input fieldname is found, try to fill out
       try
          if ovElements.item(i).Value = '[title]' then
           begin
           if (CompareText(ovElements.item(i).type, 'text') = 0) then
            begin
             title:=ovElements.item(i).name;
             if ovElements.item(i).name<>'' then
              begin
               ChildNode:= ParentNode.AddChild('title');
               ChildNode.Text:=title;
              end;
            end;
           end;

          if ovElements.item(i).Value = '[description]' then
           begin
           if (CompareText(ovElements.item(i).type, 'text') = 0) then
            begin
             description:=ovElements.item(i).name;
             if ovElements.item(i).name<>'' then
              begin
               ChildNode:= ParentNode.AddChild('description');
               ChildNode.Text:=description;
              end;
            end;
          end;

          if ovElements.item(i).Value = '[adress]' then
           begin
           if (CompareText(ovElements.item(i).type, 'text') = 0) then
            begin
             adress:=ovElements.item(i).name;
             if ovElements.item(i).name<>'' then
              begin
               ChildNode:= ParentNode.AddChild('adress');
               ChildNode.Text:=adress;
              end;
            end;
           end;

          if ovElements.item(i).Value = '[price]' then
           begin
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             begin
              price:=ovElements.item(i).name;
              if ovElements.item(i).name<>'' then
               begin
                ChildNode:= ParentNode.AddChild('price');
                ChildNode.Text:=price;
               end;
             end;
           end;

           if ovElements.item(i).Value = '[contact]' then
            begin
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
              begin
               contact:=ovElements.item(i).name;
               if ovElements.item(i).name<>'' then
                begin
                 ChildNode:= ParentNode.AddChild('contact');
                 ChildNode.Text:=contact;
                end;
             end;
            end;

           if ovElements.item(i).Value = '[phone]' then
            begin
             if (CompareText(ovElements.item(i).type, 'text') = 0) then
              begin
               phone:=ovElements.item(i).name;
               if ovElements.item(i).name<>'' then
                begin
                 ChildNode:= ParentNode.AddChild('phone');
                 ChildNode.Text:=phone;
                end;
               end;
            end;

           if ovElements.item(i).Value = '[email]' then
            begin
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
              begin
               email:=ovElements.item(i).name;
               if ovElements.item(i).name<>'' then
                begin
                 ChildNode:= ParentNode.AddChild('email');
                 ChildNode.Text:=email;
                end;
              end;
            end;

           if ovElements.item(i).Value = '[company]' then
            begin
             if (CompareText(ovElements.item(i).type, 'text') = 0) then
              begin
               company:=ovElements.item(i).name;
               if ovElements.item(i).name<>'' then
                begin
                 ChildNode:= ParentNode.AddChild('company');
                 ChildNode.Text:=company;
                end;
              end;
            end;

           if ovElements.item(i).Value = '[url]' then
            begin
             if (CompareText(ovElements.item(i).type, 'text') = 0) then
              begin
               url:=ovElements.item(i).name;
               if ovElements.item(i).name<>'' then
                begin
                 ChildNode:= ParentNode.AddChild('url');
                 ChildNode.Text:=url;
                end;
              end;
            end;
      except
         on E : Exception do
          ShowMessage(E.ClassName+' Error message: '+E.Message)
      end;
      end;

      ovElements:=wb1.OleObject.Document.getelementsbytagname('textarea');

       for i := 0 to ovElements.Length - 1 do
       begin
          if ovElements.item(i).Value = '[description]' then
           begin
            description:=ovElements.item(i).name;
            if ovElements.item(i).name<>'' then
             begin
              ChildNode:= ParentNode.AddChild('description');
              ChildNode.Text:=description;
             end;
          end;
 end;

 //Сохраняем в xml
 XML.SaveToFile('base.xml');
end;
 LoadPage;
end;

//Обучаем программу
procedure TForm1.LoadPage;
var
 i:Integer;
begin
 if (LineIndex<mmo1.Lines.Count) then
  begin
   wb1.Navigate(mmo1.Lines[LineIndex]);
   mmo2.Lines.Add('Sites '+mmo1.Lines[LineIndex]+' loaded! No: '+IntToStr(LineIndex+1)+'! No"s for the end:'+IntToStr(mmo1.Lines.Count-(LineIndex+1)));
   lbl2.Caption:='Current page:'+mmo1.Lines[LineIndex];
   lbl2.Font.Color:=clBlack;
   Inc(LineIndex);
   btn1.Enabled:=True;
  end;
end;

//Подаем объявы программу
procedure TForm1.LoadPage2;
var
 i:Integer;
begin
 if (LineIndex<mmo3.Lines.Count) then
  begin
   EndBrowserSession;
   ClearCookies;
   wb2.Navigate(mmo3.Lines[LineIndex]);
   mmo4.Lines.Add('Sites '+mmo3.Lines[LineIndex]+' loaded! No: '+IntToStr(LineIndex+1)+'! No"s for the end:'+IntToStr(mmo3.Lines.Count-(LineIndex+1)));
   lbl4.Caption:='Current page: '+mmo3.Lines[LineIndex];
   Inc(LineIndex);
   btn4.Enabled:=True;
   btn5.Enabled:=True;
  end;
end;


procedure TForm1.btn3Click(Sender: TObject);
begin
  if btn3.Caption='Start' then
  begin
    btn3.Caption:='Stop';
    StopT:=False;
    LineIndex:=0;
    mmo2.Clear;
    LoadPage;
  end
 else
  begin
    StopT:=True;
    btn3.Caption:='Start';
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  //-----------Обучение---------------
  mmo1.Height:=Trunc(Form1.Height*0.66);
  btn3.Top:=32+ mmo1.Height+15;
  btn1.Top:=btn3.Top+btn3.Height+7;
  mmo2.Height:=Trunc(Form1.Height*0.10);
  mmo2.Width:=Trunc(Form1.Width*0.96);
  mmo2.Top:=btn1.Top+btn1.Height+15;
  wb1.Height:=Trunc(Form1.Height*0.74);
  wb1.Width:=Trunc(Form1.Width*0.72);
  pgc1.Width:=Trunc(Form1.Width*0.98);
  pgc1.Height:=Trunc(Form1.Height*0.95);
  //-----------Подача объявлений---------------
  mmo3.Height:=Trunc(Form1.Height*0.60);
  btn2.Top:=32+ mmo3.Height+55;
  btn5.Top:=btn2.Top+btn2.Height+7;
  btn4.Top:=btn5.Top+btn5.Height+7;
  mmo4.Height:=Trunc(Form1.Height*0.10);
  mmo4.Width:=Trunc(Form1.Width*0.96);
  mmo4.Top:=btn4.Top+btn4.Height+5;
  wb2.Height:=Trunc(Form1.Height*0.74);
  wb2.Width:=Trunc(pgc1.Width*0.80);
end;

//Старт подачи
procedure TForm1.btn2Click(Sender: TObject);
begin
  if btn3.Caption='Start' then
   begin
     if btn2.Caption='Start' then
      begin
       if checkData then
        begin
         btn2.Caption:='Stop';
         //LockFields;
         mmo4.Clear;
         LoadPagesFromXML;
         LineIndex:=StrToInt(edt9.Text);
         LoadPage2;
       end
      else
       ShowMessage('Not filled offer data!');
      end
     else
      begin
       btn2.Caption:='Start';
       btn4.Enabled:=False;
       UnLockFields;
      end
  end
 else
   ShowMessage('You are in learning mode! Please change mode!');
end;

//Загрузка сайтов из XML
procedure TForm1.LoadPagesFromXML;
var
 i:Integer;
 XML : IXMLDOCUMENT;
 RootNode, ParentNode,ChildNode : IXMLNODE;
begin
 if FileExists('base.xml') then
  begin
   XML := NewXMLDocument;
   XML.LoadFromFile('base.xml');
   XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
   RootNode := XML.DocumentElement;
   for i:=0 to RootNode.ChildNodes.Count-1 do
    begin
       ChildNode:=RootNode.ChildNodes[i];
       mmo3.Lines.Add(ChildNode.Attributes['www']);
    end;
   mmo4.Lines.Add('Loaded from base: '+IntToStr(RootNode.ChildNodes.Count)+' urls');
  end
  else
   ShowMessage('Base not found! Please try learning mode!');
end;

function  TForm1.checkData:Boolean;          //Проверка на заполнение полей
var
 Error:Boolean;
begin
 Error:=False;
 if not ((Length(edt1.Text)>0) and (edt1.Text<>' ')) then
  Error:=True;

 if not ((Length(edt2.Text)>0) and (edt2.Text<>' ')) then
  Error:=True;

 if not ((Length(edt3.Text)>0) and (edt3.Text<>' ')) then
  Error:=True;

 if not ((Length(edt4.Text)>0) and (edt4.Text<>' ')) then
  Error:=True;

 if not ((Length(edt5.Text)>0) and (edt5.Text<>' ')) then
  Error:=True;

 if not ((Length(edt6.Text)>0) and (edt6.Text<>' ')) then
  Error:=True;

 if not ((Length(edt7.Text)>0) and (edt7.Text<>' ')) then
  Error:=True;

 if not ((Length(edt8.Text)>0) and (edt8.Text<>' ')) then
  Error:=True;

 if not (mmo5.Lines.Count<1) then
  Error:=True;

  checkData:=Error;
end;

procedure TForm1.LockFields;                 //Замыкание полей
begin
  edt1.Enabled:=False;
  edt2.Enabled:=False;
  edt3.Enabled:=False;
  edt4.Enabled:=False;
  edt5.Enabled:=False;
  edt6.Enabled:=False;
  edt7.Enabled:=False;
  edt8.Enabled:=False;
  mmo5.Enabled:=False;
  mmo3.ReadOnly:=True;
  btn1.Enabled:=False;
  btn3.Enabled:=False;
  ts1.Enabled:=False;
  ts2.Enabled:=False;
end;

procedure TForm1.UnLockFields;               //Размыкание полей
begin
  edt1.Enabled:=True;
  edt2.Enabled:=True;
  edt3.Enabled:=True;
  edt4.Enabled:=True;
  edt5.Enabled:=True;
  edt6.Enabled:=True;
  edt7.Enabled:=True;
  edt8.Enabled:=True;
  mmo5.Enabled:=True;
  mmo3.ReadOnly:=False;
  btn1.Enabled:=True;
  btn3.Enabled:=true;
  ts1.Enabled:=True;
  ts2.Enabled:=True;
end;

procedure TForm1.FillFields; //Заполнение полей
var
  WB: IWebbrowser2;
  Document: Variant;
  k, m: Integer;
  ovElements: OleVariant;
  i,j,l,p: Integer;
  title:string;
  description:string;
  adress:string;
  price:string;
  contact:string;
  phone:string;
  email:string;
  company:string;
  url:string;
  tmpStr:string;
  XML : IXMLDOCUMENT;
  RootNode, ParentNode,ChildNode,NeededNode : IXMLNODE;
  all_ok:boolean;
begin
  all_ok:=False;
  //Находим сайт
   if FileExists('base.xml') then
   begin
    XML := NewXMLDocument;
    XML.LoadFromFile('base.xml');
    XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
    RootNode := XML.DocumentElement;

    for j:=0 to RootNode.ChildNodes.Count-1 do
      begin
       ParentNode:=RootNode.ChildNodes[j];
       tmpStr:=ParentNode.Attributes['www'];
       tmpStr:=mmo3.Lines[LineIndex-1];
       if ParentNode.Attributes['www']=mmo3.Lines[LineIndex-1] then
        begin
         all_ok:=True;
         NeededNode:=ParentNode;
        end;

      end;
    end;

  //Засовываем в браузер значения полей
 if all_ok then
  begin

   //Для начала вытаскиваем все названия полей
    for l:=0 to NeededNode.ChildNodes.Count-1 do
     begin
       if (NeededNode.ChildNodes[l].LocalName='title')  then
        title:=NeededNode.ChildNodes[l].Text;

       if (NeededNode.ChildNodes[l].LocalName='description')then
        description:=NeededNode.ChildNodes[l].Text;

       if (NeededNode.ChildNodes[l].LocalName='adress')then
        adress:=NeededNode.ChildNodes[l].Text;

      if (NeededNode.ChildNodes[l].LocalName='price')then
        price:=NeededNode.ChildNodes[l].Text;

      if (NeededNode.ChildNodes[l].LocalName='contact')then
       contact:=NeededNode.ChildNodes[l].Text;

      if (NeededNode.ChildNodes[l].LocalName='phone')then
       phone:=NeededNode.ChildNodes[l].Text;

     if (NeededNode.ChildNodes[l].LocalName='email')then
       email:=NeededNode.ChildNodes[l].Text;

     if (NeededNode.ChildNodes[l].LocalName='company')then
       company:=NeededNode.ChildNodes[l].Text;

     if (NeededNode.ChildNodes[l].LocalName='url')then
       url:=NeededNode.ChildNodes[l].Text;

     end;


   //Document := wb2.Document;
   ovElements:=wb2.OleObject.Document.getelementsbytagname('input');

   // count forms on document and iterate through its forms
   //for m := 0 to Document.forms.Length - 1 do
   // begin
     //ovElements := Document.forms.Item(m).elements;
     // iterate through elements
     for i := 0 to ovElements.Length - 1 do
      begin
       // when input fieldname is found, try to fill out
       try
       // if ((CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
         // (CompareText(ovElements.item(i).type, 'text') = 0)) or
         // (CompareText(ovElements.item(i).tagName, 'textarea') = 0)
        //   then
        // begin
          //Загаловок
          if ovElements.item(i).name= title then
           if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt1.Text;

          //Основной текст
          if ovElements.item(i).name= description then
           begin
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             begin
              description:='';
              for p:=0 to mmo5.Lines.Count do
              description:=description+mmo5.Lines[p];
              ovElements.item(i).Value := description;
            end;
           end;

           //Адрес
           if ovElements.item(i).name= adress then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt2.Text;


           //Цена
           if ovElements.item(i).name= price then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt3.Text;

           //Контакт
           if ovElements.item(i).name= contact then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt4.Text;

           //Телефон
           if ovElements.item(i).name= phone then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt5.Text;

           //email
           if ovElements.item(i).name= email then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt6.Text;

           //company
           if ovElements.item(i).name= company then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt7.Text;

          //url
           if ovElements.item(i).name= url then
            if (CompareText(ovElements.item(i).type, 'text') = 0) then
             ovElements.item(i).Value := edt8.Text;
         //  end;
      except
         on E : Exception do
          ShowMessage(E.ClassName+' error message: '+E.Message)
      end;
     end;

     ovElements:=wb2.OleObject.Document.getelementsbytagname('textarea');


     for i := 0 to ovElements.Length - 1 do
      begin
         try
           //Основной текст
          if ovElements.item(i).name= description then
           begin
           description:='';
            for p:=0 to mmo5.Lines.Count do
             description:=description+mmo5.Lines[p];
            ovElements.item(i).Value := description;
           end;
         except
         on E : Exception do
          ShowMessage(E.ClassName+' error message: '+E.Message)
         end;
       end;
  end;
end;

//Загрузка следующей страницы
procedure TForm1.btn4Click(Sender: TObject);
begin
 LoadPage2;
end;

procedure TForm1.wb2DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
   lbl4.Caption:='Current page:'+wb2.LocationURL;
   FillFields;
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
 FillFields;
end;

function  TForm1.FindUrlDuplicate(url:string):boolean;
var
 XML : IXMLDOCUMENT;
 RootNode, ParentNode,ChildNode : IXMLNODE;
 duplicate:Boolean;
 j:Integer;
 tmpStr:string;
 res:Integer;
begin
duplicate:=False;
try
 XML := NewXMLDocument;
 XML.LoadFromFile('base.xml');
 XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
 RootNode := XML.DocumentElement;

 //Защита от двойников
  for j:=0 to RootNode.ChildNodes.Count-1 do
   begin
   ParentNode:=RootNode.ChildNodes[j];
   tmpStr:=ParentNode.Attributes['www'];
   res:=AnsiCompareStr(tmpStr,url);
   if res=0 then
    duplicate:=True;
  end;
except
end;
 FindUrlDuplicate:=duplicate;
end;

procedure TForm1.wb1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
 try
 if FileExists('base.xml') then
  if (FindUrlDuplicate(wb1.LocationURL)) then
   begin
    lbl2.Caption:='Текущая страница: '+wb1.LocationURL+' уже есть в списке!!!';
    lbl2.Font.Color:=clRed;
   end
  else
   begin
    lbl2.Caption:='Текущая страница: '+wb1.LocationURL;
    lbl2.Font.Color:=clBlack;
   end
 except
 
 end;
end;

procedure TForm1.ClearCookies;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  dwEntrySize := 0;
  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
  GetMem(lpEntryInfo, dwEntrySize);
  if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
  if hCacheDir <> 0 then
  begin
    repeat
      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
      FreeMem(lpEntryInfo, dwEntrySize);
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
      GetMem(lpEntryInfo, dwEntrySize);
      if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);
  end;
  FreeMem(lpEntryInfo, dwEntrySize);
  FindCloseUrlCache(hCacheDir);
end;

procedure TForm1.EndBrowserSession;
begin
  InternetSetOption(nil, INTERNET_OPTION_END_BROWSER_SESSION, nil, 0);
end;
end.
