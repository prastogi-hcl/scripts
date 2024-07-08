waitTime=180000
THRESHOLD=300000000
uname = "adminusername"
pwd = "adminpassword"
url = "t3://localhost:7001"
def monitorJVMHeapSize():
    connect(uname, pwd, url)
    while 1:
        serverNames = getRunningServerNames()
        domainRuntime()
        for name in serverNames:
            print 'Now checking '+name.getName()
            try:
              cd("/ServerRuntimes/"+name.getName()+"/JVMRuntime/"+name.getName())
              heapSize = cmo.getHeapSizeCurrent()
              if heapSize > THRESHOLD:
              # do whatever is neccessary, send alerts, send email etc
                print 'WARNING: The HEAPSIZE is Greater than the Threshold'
              else:
                print heapSize
            except WLSTException,e:
              # this typically means the server is not active, just ignore
              # pass
                print "Ignoring exception " + e.getMessage()
            java.lang.Thread.sleep(waitTime)
 
def getRunningServerNames():
        # only returns the currently running servers in the domain
        return domainRuntimeService.getServerRuntimes()
 
if __name__== "main":
    monitorJVMHeapSize()
