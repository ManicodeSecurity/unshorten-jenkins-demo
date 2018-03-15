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
        sh "docker images"
    
    stage "Push"


    stage "Deploy"

        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' applications/link-unshorten/k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}