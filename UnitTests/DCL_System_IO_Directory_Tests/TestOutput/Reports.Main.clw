!================================================================================
! Reports.Main
!================================================================================
! This procedure has been extracted from its source module for version control
! purposes only - it is NOT compilable.
!
! Original file: D:\dev-IES\ExtractProceduresTest\TestData\DLLTUTOR001.CLW
!
! New file:      D:\dev-IES\ExtractProceduresTest\TestOutput\Reports.Main.clw
!
! This file may also be included in a combined source file called
! Reports._AllProcedures.clw.
!
! If this procedure has been moved from another application then
! Reports.Main will have a more complete history than
! Reports.allprocedures.clw provided the original extracted procedure
! file was renamed in the version control system)
!================================================================================
! Start of original module header
!================================================================================
!
!
!   MEMBER('Dlltutor.clw')                                  ! This is a MEMBER module
!
!
!   INCLUDE('ABTOOLBA.INC'),ONCE
!   INCLUDE('ABWINDOW.INC'),ONCE
!
!                     MAP
!                       INCLUDE('DLLTUTOR001.INC'),ONCE        !Local module procedure declarations
!                     END
!
!
!================================================================================
! End of original module header
!================================================================================
Main PROCEDURE                                             ! Generated from procedure template - Frame

FilesOpened          BYTE                                  !
SplashProcedureThread LONG
AppFrame             APPLICATION('Tutorial Application'),AT(,,310,216),RESIZE,MAX,STATUS(-1,80,120,45),SYSTEM,IMM
                       MENUBAR
                         MENU('&File'),USE(?FileMenu)
                           ITEM('P&rint Setup...'),USE(?PrintSetup),MSG('Setup Printer'),STD(STD:PrintSetup)
                           ITEM('Print &Customer List'),USE(?FilePrintCustomerList)
                           ITEM('Print &All Invoices'),USE(?FilePrintAllInvoices)
                           ITEM('Print &One Customer''s Invoices'),USE(?FilePrintOneCustomersInvoices)
                           ITEM,SEPARATOR
                           ITEM('E&xit'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('&Edit'),USE(?EditMenu)
                           ITEM('Cu&t'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('&Copy'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('&Paste'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
                         END
                         MENU('&View'),USE(?View)
                           ITEM('&Customers'),USE(?ViewCustomers)
                           ITEM('&Products'),USE(?ViewProducts)
                           ITEM('&Orders'),USE(?ViewOrders)
                         END
                         MENU('&Window'),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('T&ile'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Cascade'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Arrange Icons'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('&Help'),MSG('Windows Help')
                           ITEM('&Contents'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Search for Help On...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                       END
                       TOOLBAR,AT(0,0,,26)
                         BUTTON,AT(3,4,16,14),USE(?CustomerButton),ICON('Customer.gif'),FLAT,TIP('Browse Customers')
                         BUTTON,AT(24,4,16,14),USE(?ProductsButton),ICON('Products.gif'),FLAT,TIP('Browse Products')
                         BUTTON,AT(45,4,16,14),USE(?OrdersButton),ICON('Orders.gif'),FLAT,TIP('Browse Orders')
                         BUTTON,AT(61,4,16,14),USE(?Toolbar:Top,Toolbar:Top),ICON('VCRFIRST.ICO'),DISABLE,FLAT,TIP('Go to the ' & |
  'First Page')
                         BUTTON,AT(77,4,16,14),USE(?Toolbar:PageUp,Toolbar:PageUp),ICON('VCRPRIOR.ICO'),DISABLE,FLAT, |
  TIP('Go to the Prior Page')
                         BUTTON,AT(93,4,16,14),USE(?Toolbar:Up,Toolbar:Up),ICON('VCRUP.ICO'),DISABLE,FLAT,TIP('Go to the ' & |
  'Prior Record')
                         BUTTON,AT(109,4,16,14),USE(?Toolbar:Locate,Toolbar:Locate),ICON('FIND.ICO'),DISABLE,FLAT,TIP('Locate record')
                         BUTTON,AT(125,4,16,14),USE(?Toolbar:Down,Toolbar:Down),ICON('VCRDOWN.ICO'),DISABLE,FLAT,TIP('Go to the ' & |
  'Next Record')
                         BUTTON,AT(141,4,16,14),USE(?Toolbar:PageDown,Toolbar:PageDown),ICON('VCRNEXT.ICO'),DISABLE, |
  FLAT,TIP('Go to the Next Page')
                         BUTTON,AT(157,4,16,14),USE(?Toolbar:Bottom,Toolbar:Bottom),ICON('VCRLAST.ICO'),DISABLE,FLAT, |
  TIP('Go to the Last Page')
                         BUTTON,AT(177,4,16,14),USE(?Toolbar:Select,Toolbar:Select),ICON('MARK.ICO'),DISABLE,FLAT,TIP('Select This Record')
                         BUTTON,AT(193,4,16,14),USE(?Toolbar:Insert,Toolbar:Insert),ICON('INSERT.ICO'),DISABLE,FLAT, |
  TIP('Insert a New Record')
                         BUTTON,AT(209,4,16,14),USE(?Toolbar:Change,Toolbar:Change),ICON('EDIT.ICO'),DISABLE,FLAT,TIP('Edit This Record')
                         BUTTON,AT(225,4,16,14),USE(?Toolbar:Delete,Toolbar:Delete),ICON('DELETE.ICO'),DISABLE,FLAT, |
  TIP('Delete This Record')
                         BUTTON,AT(245,4,16,14),USE(?Toolbar:History,Toolbar:History),ICON('DITTO.ICO'),DISABLE,FLAT, |
  TIP('Previous value')
                         BUTTON,AT(261,4,16,14),USE(?Toolbar:Help,Toolbar:Help),ICON('HELP.ICO'),DISABLE,FLAT,TIP('Get Help')
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
Kill                   PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED       ! Method added to host embed code
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
  CASE ACCEPTED()
  OF ?FilePrintCustomerList
    START(CustReport, 25000)
  OF ?FilePrintAllInvoices
    START(InvoiceReport, 25000)
  OF ?FilePrintOneCustomersInvoices
    START(CustInvoiceReport, 25000)
  END
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::View ROUTINE                                         ! Code for menu items on ?View
  CASE ACCEPTED()
  OF ?ViewCustomers
    START(ViewCustomers, 25000)
  OF ?ViewProducts
      START(ViewProducts,25000)                            ! Initiate the Thread
  OF ?ViewOrders
    START(ViewOrders, 25000)
  END

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  SELF.SetAlerts()
  COMPILE ('**CW7**',_CWVER_=7000)
      AppFrame{PROP:TabBarVisible}  = False
  !**CW7**
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?ProductsButton
        START(ViewProducts,25000)                          ! Initiate the Thread
    OF ?Toolbar:Top
    OROF ?Toolbar:PageUp
    OROF ?Toolbar:Up
    OROF ?Toolbar:Locate
    OROF ?Toolbar:Down
    OROF ?Toolbar:PageDown
    OROF ?Toolbar:Bottom
    OROF ?Toolbar:Select
    OROF ?Toolbar:Insert
    OROF ?Toolbar:Change
    OROF ?Toolbar:Delete
    OROF ?Toolbar:History
    OROF ?Toolbar:Help
      IF SYSTEM{PROP:Active} <> THREAD()
        POST(EVENT:Accepted,ACCEPTED(),SYSTEM{Prop:Active} )
        CYCLE
      END
    ELSE
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::View                                        ! Process menu items on ?View menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?CustomerButton
      START(ViewCustomers, 25000)
    OF ?OrdersButton
      START(ViewOrders, 25000)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      SplashProcedureThread = START(SplashScreen)          ! Run the splash window procedure
    ELSE
      IF SplashProcedureThread
        IF EVENT() = Event:Accepted
          POST(Event:CloseWindow,,SplashProcedureThread)   ! Close the splash window
          SplashPRocedureThread = 0
        END
     END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

