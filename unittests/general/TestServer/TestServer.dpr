﻿program TestServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  {$IFNDEF LINUX}
  Winapi.Windows,
  {$ENDIF }
  Web.WebBroker,
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Console,
  WebModuleUnit in 'WebModuleUnit.pas' {MainWebModule: TWebModule},
  TestServerControllerU in 'TestServerControllerU.pas',
  TestServerControllerExceptionU in 'TestServerControllerExceptionU.pas',
  SpeedMiddlewareU in 'SpeedMiddlewareU.pas',
  TestServerControllerPrivateU in 'TestServerControllerPrivateU.pas',
  AuthHandlersU in 'AuthHandlersU.pas',
  BusinessObjectsU in '..\..\..\samples\commons\BusinessObjectsU.pas',
  TestServerControllerJSONRPCU in 'TestServerControllerJSONRPCU.pas',
  RandomUtilsU in '..\..\..\samples\commons\RandomUtilsU.pas',
  MVCFramework.Tests.Serializer.Entities in '..\..\common\MVCFramework.Tests.Serializer.Entities.pas',
  FDConnectionConfigU in '..\..\common\FDConnectionConfigU.pas',
  Entities in '..\Several\Entities.pas',
  EntitiesProcessors in '..\Several\EntitiesProcessors.pas',
  MVCFramework.Filters.Action in '..\..\..\sources\MVCFramework.Filters.Action.pas',
  MVCFramework.Filters.Router in '..\..\..\sources\MVCFramework.Filters.Router.pas',
  SpeedProtocolFilterU in 'SpeedProtocolFilterU.pas',
  MVCFramework.Filters.Compression in '..\..\..\sources\MVCFramework.Filters.Compression.pas',
  MVCFramework.Filters.StaticFiles in '..\..\..\sources\MVCFramework.Filters.StaticFiles.pas';

{$R *.res}

procedure Logo;
begin
  ResetConsole();
  Writeln;
  TextBackground(TConsoleColor.Black);
  TextColor(TConsoleColor.Red);
  Writeln(' ██████╗ ███╗   ███╗██╗   ██╗ ██████╗    ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗');
  Writeln(' ██╔══██╗████╗ ████║██║   ██║██╔════╝    ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗');
  Writeln(' ██║  ██║██╔████╔██║██║   ██║██║         ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝');
  Writeln(' ██║  ██║██║╚██╔╝██║╚██╗ ██╔╝██║         ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗');
  Writeln(' ██████╔╝██║ ╚═╝ ██║ ╚████╔╝ ╚██████╗    ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║');
  Writeln(' ╚═════╝ ╚═╝     ╚═╝  ╚═══╝   ╚═════╝    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝');
  Writeln(' ');
  TextColor(TConsoleColor.White);
  Write('PLATFORM: ');
  {$IF Defined(Win32)} Writeln('WIN32'); {$ENDIF}
  {$IF Defined(Win64)} Writeln('WIN64'); {$ENDIF}
  {$IF Defined(Linux64)} Writeln('Linux64'); {$ENDIF}
  TextColor(TConsoleColor.Yellow);
  Writeln('DMVCFRAMEWORK VERSION: ', DMVCFRAMEWORK_VERSION);
  TextColor(TConsoleColor.White);
end;

procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
begin
  Logo;
  Writeln(Format('Starting HTTP Server or port %d', [APort]));
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.OnParseAuthentication :=
      TMVCParseAuthentication.OnParseAuthentication;
    LServer.DefaultPort := APort;
    LServer.Active := True;
    LServer.MaxConnections := 0;
    LServer.ListenQueue := 200;
    Writeln('Press RETURN to stop the server');
    WaitForReturn;
    TextColor(TConsoleColor.Red);
    Writeln('Server stopped');
    ResetConsole();
  finally
    LServer.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    RunServer(9999);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
