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
        sh "echo building docker image..."
        sh "docker build -t ${imageName} . "

    stage "Push"
        sh "Pushing image to local repo..."
        sh "docker push ${imageName}"
        sh "docker images"

    stage "Scan Docker Image"
        sh "Scanning docker image for vulnerabilities..."
        sh "bleep"
        sh "bloop"
        sh "bleep"
        sh "PASSED"

    stage "Source Code Static Analysis"
        sh "Running static analysis scan..."
        sh "bleep"
        sh "bloop"
        sh "bleep"
        sh "PASSED"
        
    stage "Kubernetes Analysis"
        sh "Scanning Kubernetes configs for vulnerabilities..."
        sh "bleep"
        sh "bloop"
        sh "bleep"
        sh "PASSED"

    stage "Deploy"
        sh "Deploying to Kubernetes cluster..."
        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}