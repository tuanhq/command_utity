CREATE SEVERVICE IN WINDOW
config file
echo logpath=D:\mongodb\data\log\mongod.log> "D:\mongodb\mongod.cfg"
echo dbpath=D:\mongodb\data\db>> "D:\mongodb\mongod.cfg"

create service
sc.exe create MongoDB binPath= "\"D:\mongodb\bin\mongod.exe\" --service --config=\"D:\mongodb\mongod.cfg\"" DisplayName= "MongoDB 2.6.5 Standard" start= "auto"