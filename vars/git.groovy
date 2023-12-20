def call(String branch, String giturl){ 
checkout scmGit(branches: [[name: branch]], extensions: [], userRemoteConfigs: [[url: giturl]])
}
