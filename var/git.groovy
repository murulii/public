def call(string branch, string giturl){ 
checkout scmGit(branches: [[name: branch]], extensions: [], userRemoteConfigs: [[url: giturl]])
}
