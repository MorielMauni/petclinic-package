pipeline  {
  agent any; 

  options {
        disableConcurrentBuilds()
  }

  environment {
    this_group = ""
    this_version = ""
    this_artifact = ""
    this_full_build_id = ""
    this_jenkins_build_id= ""
    props = "";
    FilePropertiesLocation = "";
    ProjectName = "petclinic-spring";
    fileProperties = "file.properties"

  }


   stages  {


   stage('Get Packer Repo') 
   { 
      steps {
        echo "Getting Packer Repo"
        git(
        url:'git@github.com:ochoadevops/petclinic-package.git',
        credentialsId: 'package',
        branch: "main"
        )
     }

   }

   stage('Read Properties File') {
      steps {
        script {
           copyArtifacts(projectName: "${ProjectName}");
           props = readProperties file:"${fileProperties}";

           this_group = props.Group;
           this_version = props.Version;
           this_artifact = props.ArtifactId;
           this_full_build_id = props.FullBuildId; 
           this_jenkins_build_id = props.JenkinsBuildId; 
        }


        sh "echo Finished setting this_group = $this_group"
        sh "echo Finished setting this_version = $this_version"
        sh "echo Finished setting this_artifact = $this_artifact"
        sh "echo Finished setting this_full_build_id = $this_full_build_id"
        sh "echo Finished setting this_jenkins_build_id = $this_jenkins_build_id"

      }
    }


    stage('Create app image')
    {
      steps {
        // Run packer 
        sh 'pwd'
        sh 'ls -l'
        echo "Starting --- packer validate"
   
        script {
             // The build location is going to be on the target directory, so add the target path
          
             def varBuildId = "buildId=" + "$this_full_build_id";
             def varJenkinsBuildId = "jenkinsBuildId=" + "$this_jenkins_build_id";
             def varArtifactId = "artifactId=" + "$this_artifact";
          
             // Need to move the war file to this directory, so it can be passed to packer
             sh "cp ./target/$this_full_build_id ."
             echo "List files to verify jar file is on this directory"
             sh "ls -l"
 
             echo "This is varBuildId $varBuildId";
             echo "This is varJenkinsBuildId $varBuildId";
             echo "This is varArtifactId $varArtifactId";
 
             sh "/usr/local/bin/packer validate -var $varBuildId -var $varJenkinsBuildId -var $varArtifactId ./ami.json"

             echo "Starting --- packer build"
             sh "/usr/local/bin/packer build -var $varBuildId -var $varJenkinsBuildId -var $varArtifactId ./ami.json"

        }
      }
    }

   }  // End of Stages
    
}  // End of pipeline
   
