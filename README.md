<H1>README</H1>
<H1>Repo Name: package</H1>
<P>Purpose: To demonstrate how to create an Application EC2 AMI using Packer within a Jenkinsfile. This job is run after each successful build. The Base image is an Amazon Linux Image. Packer uses that Base image to create the final Application AMI as part of the pipeline.</P>

<H1>Before running this repo, update the following items to reflect your repo information and envrionment</H1>

<UL>
<LI>Update the GIT URL to reflect your own Git Hub Repository
<LI>Verify that the AWS Base AMI ID (ami-099592454c308b00f) specified on ami.json file is still available on AWS. If not, update the AMI ID with the latest AWS AMI Image ID.
<LI>(optional) Update Webhooks on Git Hub to reflect your Jenkins URL or IP
</UL>

