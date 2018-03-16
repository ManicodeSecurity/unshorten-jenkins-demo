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
        // sh "docker build -t ${imageName} . "

    stage('Clair Test') {
        sh 'wget -nv -O klar http://artifactory.prod.cu.edu/artifactory/ext-archive-local/optiopay/klar/1.5/klar-1.5-linux-amd64'
        sh 'chmod u+x klar'
        def statusCode = sh script:"CLAIR_ADDR=${clair_endpoint} ./klar ${full_image_name}", returnStatus:true
        if (statusCode!=0) {
            currentBuild.result = 'FAILURE'
            error "Docker Image did not pass Clair testing."
        }
    }
    
    stage "Push"

        sh "docker push ${imageName}"

    stage "Deploy"

        sh "sed 's#127.0.0.1:30400/link-unshorten:latest#'$BUILDIMG'#' k8s/deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/link-unshorten"
}