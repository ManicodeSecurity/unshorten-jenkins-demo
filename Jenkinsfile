node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "link-unshorten"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appName}:${tag}"
    kubeBenchOverrides = "{ \"apiVersion\": \"v1\", \"spec\": { \"hostPID\": true, \"nodeSelector\": { \"kubernetes.io/role\": \"master\" }, \"tolerations\": [ { \"key\": \"node-role.kubernetes.io/master\", \"operator\": \"Exists\", \"effect\": \"NoSchedule\" } ] } }"
    env.BUILDIMG=imageName

    stage "Build"
        sh "docker build -t ${imageName} . "
        sh "docker images"

    stage "Push"
        sh "docker push ${imageName}"

    stage "Scan Docker Image"

    stage "Source Code Static Analysis"
        
    stage "Kubernetes Analysis"
        sh "docker run --rm -v `pwd`:/host aquasec/kube-bench:latest install"
        sh "./kube-bench master"

    stage "Deploy"
        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}