node {
    try {
        stage('Preparation') {
            git credentialsId: 'b9f01ce4-557f-4bbc-89e2-6399a7a60617', url: 'git@github.com:erickiwamoto/nblog-web.git'        
        }
        stage('Deploy to QA') {
            echo 'heroku deploy'
            deploy('qa')
        }
        stage('Run Funciontal Tests') {
            echo 'test'
            ruby('cd tests && bundle install && cucumber')
            cucumber 'tests/results/features.json'
            junit 'tests/results/junit/*.xml'
        }
        stage('Deploy to UAT'){
            echo 'deploy on heroku'
            deploy('uat')
        }
        stage('Run Acceptance Tests') {
            echo 'test'
            ruby('cd tests && bundle install && cucumber')
        }
        stage('Promote to Production') {
            echo 'deploy on heroku'
            deploy_prod()
        }
    }
    catch (err) {
        currentBuild = 'Falhou o build :('
        junit 'tests/results/junit/*.xml'
        cucumber 'tests/results/features.json'
        throw err
    }
}

def deploy(String env) {
    sh 'rm -rf .git && git init'
    sh "heroku git:remote -a nblog-web-${env}"
    sh "git add . && git commit -m 'deploy'"
    sh "git push heroku master --force"
}

def deploy_prod() {
    sh 'rm -rf .git && git init'
    sh "heroku git:remote -a nblog-web-erick"
    sh "git add . && git commit -m 'deploy'"
    sh "git push heroku master --force"
}

def ruby(String commands) {
    sh "bash -c 'source ~/.bashrc && rbenv global 2.3.3 && ${commands}'"
}
