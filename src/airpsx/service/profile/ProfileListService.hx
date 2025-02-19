package airpsx.service.profile;

import sys.FileSystem;
import sys.io.File;
import hx.well.services.AbstractService;
import hx.well.http.Request;
import hx.well.http.AbstractResponse;
using airpsx.tools.StringTools;

// This service returns non-variable system resources.
class ProfileListService extends AbstractService {
    public function execute(request:Request):AbstractResponse {
        var response:Array<Dynamic> = [];

        var profileIds:Array<String> = FileSystem.readDirectory(Config.USER_HOME_PATH);
        for(profileId in profileIds)
        {
            var username:Null<String> = File.getContent('${Config.USER_HOME_PATH}/${profileId}/username.dat');
            if(username == null)
                continue;

            var userData:UserData = {
                profileId: profileId,
                username: username.truncateAtNull(),
            };
            response.push(userData);
        }

        return response;
    }
}


typedef UserData = {
    profileId:String,
    username:String,
}