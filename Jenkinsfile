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
        sh "docker push ${imageName}"
        sh "docker images"

    stage "Scan"
        sh "docker run -p 5432:5432 -d --name db arminc/clair-db:2017-09-18"
        sh "docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan:v2.0.1"
        sh "docker pull ${imageName}"
        sh "sh run.sh"
        sh "./clair-scanner --ip 127.0.0.1 ${imageName}"

    stage "Deploy"

        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}