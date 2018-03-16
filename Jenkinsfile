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

    stage "Push"
        sh "docker images"
        sh "docker push ${imageName}"

    stage "Scan"
        sh "docker pull 127.0.0.1:30400/link-unshorten:78fb934"
        //sh "sh run.sh"
        //sh "docker-compose up -f clair/docker-compose.yaml -d postgres"
        //sh "./clairctl health"

    stage "Deploy"

        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}