node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "link-unshorten"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appName}:${tag}"
    env.BUILDIMG=imageName

    stage "Build"
        sh "docker build -t ${imageName} . "

    stage "Scan"
        // sh "sh run.sh"
        sh "docker run --net=host -d --name db arminc/clair-db:2017-09-18"
        sh "docker run --net=host --add-host postgres:127.0.0.1 -d --name clair --net=host arminc/clair-local-scan:v2.0.1"
        sh "./clair-scanner ${imageName} k8s/deployment.yaml http://127.0.0.1:6060 127.0.0.1"
    
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"

        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}