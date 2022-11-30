program MiddlewareSamples_httpsys;

{$APPTYPE CONSOLE}


uses
  System.SysUtils,
  Web.WebReq,
  Web.WebBroker,
  MVCFramework.HttpSys.WebBrokerBridge,
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule} ,
  AppControllerU in 'AppControllerU.pas',
  MiddlewareSample1 in 'MiddlewareSample1.pas';

{$R *.res}


procedure RunServer(APort: Integer);
var
  LServer: TMVCHTTPSysWebBrokerBridge;
begin
  Writeln(Format('Starting HTTP Server or port %d', [APort]));
  LServer := TMVCHTTPSysWebBrokerBridge.Create;
  try
    LServer.Port := APort;
    LServer.Active := True;
    Writeln('Press RETURN to stop the server');
    ReadLn;
  finally
    LServer.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    WebRequestHandlerProc.MaxConnections := 0;
    RunServer(8080);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end

end.