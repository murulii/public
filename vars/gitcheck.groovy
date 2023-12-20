def call(String giturl, String branch){ 
checkout scmGit(branches: [[name: branch]], extensions: [], userRemoteConfigs: [[url: giturl]])
}
