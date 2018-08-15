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
        sh "docker images"

    stage "Push"
        sh "docker push ${imageName}"

    stage "Scan Docker Image"
        sh "git clone https://github.com/lukebond/microscanner-wrapper"
        sh "MICROSCANNER_TOKEN=MTZjNjE3Nzc5YTYy MICROSCANNER_OPTIONS='--continue-on-failure' microscanner-wrapper/grabhtml.sh ${imageName}"
   
    stage "Source Code Static Analysis"
        
    stage "Kubernetes Analysis"
        sh 'kubectl run --rm -i -t kube-bench-node --image=aquasec/kube-bench:latest --restart=Never --overrides="{ \\"apiVersion\\": \\"v1\\", \\"spec\\": { \\"hostPID\\": true } }" -- node --version 1.8'

    stage "Deploy"
        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}
