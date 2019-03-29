#!/usr/bin/env bash

screen -S esug -X quit

# clean the place
rm -rf {esug.*,pharo*,*.sources,Pharo*}

wget -O- https://get.pharo.org | bash

./pharo Pharo.image save esug

./pharo esug.image metacello install github://Lin777/ESUGConfRegistrationApp:master/src BaselineOfESUGApp --groups=Core

./pharo esug.image eval --save "
| application |
ERSandstoneDatabase initialize.
ESUGSetUp start.
application := WAAdmin defaultDispatcher handlerAt: 'config'.
application configuration addParent: WAAuthConfiguration instance.
application
        preferenceAt: #login put: 'admin';
        preferenceAt: #passwordHash put: (GRPlatform current secureHashFor: 'SomePassword').
application addFilter: WAAuthenticationFilter new.

WAAdmin disableDevelopmentTools.

WAAdmin defaultDispatcher defaultName: 'ESUG'.
"

# Launch the server in a new screen.
#screen -Sdm esug ./pharo esug.image --no-quit
