#!/usr/bin/perl -w
#
# 2018/05/25    Greg Seminara    Original
# 2018/07/20    Greg Seminara    Added setting of category and subcategory to
#                 servicenow
# 2018/07/23    Greg Seminara    Fixed setting CI when configured in ITRS using
#                 fully qualified name
# 2018/10/01    Greg Seminara    Added support for multiline description field.
# 2018/10/24    Greg Seminara    Added ability to create a closed ticket
# 2018/11/14    Greg Seminara    Added new field actionable
# 2019/07/10    Greg Seminara    Added support for \n in description field.  Converts to a true newline
# 2019/08/30    Greg Seminara    Updated UK proxy ip address
# 2019/12/03    Greg Seminara    Changed method of setting the uk proxy to work on uk2
# 2020/05/29    Greg Seminara    Added request to return sys_id and number on ticket creation,
#                  Added the ability to post to a teams channel is _TEAMS_WEBHOOK_ID is set properly
# 2020/06/25    Greg Seminara    Fixed the proxy for uk1pvitrsgwpd99
# 2021/10/06    Greg Seminara    Updated Webhook url
use strict;
use warnings;
use MIME::Base64;
 
# http://search.cpan.org/~makamaka/JSON/lib/JSON.pm
# # Example install using cpanm:
# #   sudo cpanm -i JSON
use JSON;
#
# http://search.cpan.org/~mcrawfor/REST-Client/lib/REST/Client.pm
# Example install using cpanm:
#   sudo cpanm -i REST::Client
use REST::Client;
#   
# Set the request parameters
#open (FH, '>', '/tmp/greg');
#print FH "aaaa\n";

my $json = JSON->new->allow_nonref;

#my $host = 'https://liquidnetdev.service-now.com';
my $host = 'https://liquidnet.service-now.com';
if (defined $ENV{'_SERVICE_NOW_URL'}) {
   $host = $ENV{'_SERVICE_NOW_URL'};
}

my $callerId = "\"caller_id\":\"ITRS Service Account\"";
if (defined $ENV{'_OVERRIDE_SERVICE_NOW_CALLER_ID'}) {
  my $tempCallerId = $ENV{'_OVERRIDE_SERVICE_NOW_CALLER_ID'};
  $callerId= "\"caller_id\":\"$tempCallerId\"";
}

my $impactedCIHostname;
my $impactedCI = '';
if (defined $ENV{'_OVERRIDE_SERVICE_NOW_IMPACTED_CI'}) {
  my $tempImpactedCI = $ENV{'_OVERRIDE_SERVICE_NOW_IMPACTED_CI'};
  if ( $tempImpactedCI =~ /^\d+\.\d+\.\d+\.\d+$/ ) {
    $impactedCIHostname = qx "echo $tempImpactedCI | /usr/bin/nslookup |& /bin/grep name | /bin/cut -f2 -d'=' | /bin/cut -f1 -d'.' | sed -e 's/\\s//g'";
  } else {
    $impactedCIHostname = qx "echo $tempImpactedCI | /usr/bin/nslookup |& /bin/grep Name | /bin/cut -f2 -d':' | /bin/cut -f1 -d'.' | sed -e 's/\\s//g'";
  }
  chomp($impactedCIHostname);
  $impactedCI= "\"cmdb_ci\":\"$impactedCIHostname\"";
} else {
  if (defined $ENV{'_SERVICE_NOW_IMPACTED_CI'}) {
    my $tempImpactedCI = $ENV{'_SERVICE_NOW_IMPACTED_CI'};
    if ( $tempImpactedCI =~ /^\d+\.\d+\.\d+\.\d+$/ ) {
      $impactedCIHostname = qx "echo $tempImpactedCI | /usr/bin/nslookup |& /bin/grep name | /bin/cut -f2 -d'=' | /bin/cut -f1 -d'.' | sed -e 's/\\s//g'";
    } else {
      $impactedCIHostname = qx "echo $tempImpactedCI | /usr/bin/nslookup |& /bin/grep Name | /bin/cut -f2 -d':' | /bin/cut -f1 -d'.' | sed -e 's/\\s//g'";
    }
    chomp($impactedCIHostname);
    $impactedCI= "\"cmdb_ci\":\"$impactedCIHostname\"";
  }
}

my $actionable= '';
if (defined $ENV{'_SERVICE_NOW_ACTIONABLE'}) {
  my $tmpActionable = $ENV{'_SERVICE_NOW_ACTIONABLE'};
  $actionable = "\"u_actionable\":\"$tmpActionable\"";
}

my $description = '';
if (defined $ENV{'_OVERRIDE_SERVICE_NOW_DESCRIPTION'}) {
  my $tempDescription = $ENV{'_OVERRIDE_SERVICE_NOW_DESCRIPTION'};
  $tempDescription =~ s/\\n/\n/g;
  $tempDescription = sprintf("%s", $tempDescription);
  $tempDescription = $json->encode($tempDescription);
  # Need to pull out leading and trailing double quotes for this to work.
  $tempDescription = substr($tempDescription, 1, -1);
  $description= "\"description\":\"$tempDescription\"";
} else {
  if (defined $ENV{'_SERVICE_NOW_DESCRIPTION'}) {
    my $tempDescription = $ENV{'_SERVICE_NOW_DESCRIPTION'};
    $tempDescription =~ s/\\n/\n/g;
    $tempDescription = sprintf("%s", $tempDescription);
    $tempDescription = $json->encode($tempDescription);
    # Need to pull out leading and trailing double quotes for this to work.
    $tempDescription = substr($tempDescription, 1, -1);
    $description= "\"description\":\"$tempDescription\"";
  }
}

my $shortDescription = '';
if (defined $ENV{'_OVERRIDE_SERVICE_NOW_SHORT_DESCRIPTION'}) {
  my $tempShortDescription = $ENV{'_OVERRIDE_SERVICE_NOW_SHORT_DESCRIPTION'};
  $shortDescription= "\"short_description\":\"$tempShortDescription\"";
} else {
  if (defined $ENV{'_SERVICE_NOW_SHORT_DESCRIPTION'}) {
    my $tempShortDescription = $ENV{'_SERVICE_NOW_SHORT_DESCRIPTION'};
    $shortDescription= "\"short_description\":\"$tempShortDescription\"";
  }
}

my $state = "\"state\":\"New\"";
if (defined $ENV{'_SERVICE_NOW_STATE'}) {
  my $tempState = $ENV{'_SERVICE_NOW_STATE'};
  $state = "\"state\":\"$tempState\"";
}

my $close_code = '';
if (defined $ENV{'_SERVICE_NOW_CLOSE_CODE'}) {
  my $tmpCloseCode = $ENV{'_SERVICE_NOW_CLOSE_CODE'};
  $close_code = "\"close_code\":\"$tmpCloseCode\"";
}

my $closed_by = '';
if (defined $ENV{'_SERVICE_NOW_CLOSED_BY'}) {
  my $tempClosedBy = $ENV{'_SERVICE_NOW_CLOSED_BY'};
  $closed_by = "\"closed_by\":\"$tempClosedBy\"";
}

my $assignGroup = '';
if (defined $ENV{'_OVERRIDE_SERVICE_NOW_ASSIGN_GROUP'}) {
  my $tempAssignGroup = $ENV{'_OVERRIDE_SERVICE_NOW_ASSIGN_GROUP'};
  $assignGroup= "\"assignment_group\":\"$tempAssignGroup\"";
} else {
  if (defined $ENV{'_SERVICE_NOW_ASSIGN_GROUP'}) {
    my $tempAssignGroup = $ENV{'_SERVICE_NOW_ASSIGN_GROUP'};
    $assignGroup= "\"assignment_group\":\"$tempAssignGroup\"";
  }
}

my $urgency = "\"urgency\":\"3 - Low\"";
if (defined $ENV{'_SEVERITY'}) {
  if ($ENV{'_SEVERITY'} eq "CRITICAL" || $ENV{'_SEVERITY'} eq "3" ) {
    $urgency = "\"urgency\":\"1 - High\"";
  }
  if ($ENV{'_SEVERITY'} eq "WARNING" || $ENV{'_SEVERITY'} eq "2" ) {
    $urgency = "\"urgency\":\"2 - Medium\"";
  }
  if ($ENV{'_SEVERITY'} eq "OK" || $ENV{'_SEVERITY'} eq "1" ) {
    $urgency = "\"urgency\":\"3 - Low\"";
  }
  if ($ENV{'_SEVERITY'} eq "UNDEFINED" || $ENV{'_SEVERITY'} eq "0" ) {
    $urgency = "\"urgency\":\"2 - Medium\"";
  }
}

if (defined $ENV{'_OVERRIDE_SERVICE_NOW_URGENCY'}) {
  if ($ENV{'_OVERRIDE_SERVICE_NOW_URGENCY'}  eq "Warning" ) {
    $urgency = "\"urgency\":\"2 - Medium\"";
  }
  if ($ENV{'_OVERRIDE_SERVICE_NOW_URGENCY'}  eq "Critical" ) {
    $urgency = "\"urgency\":\"1 - High\"";
  }
} else {
  if (defined $ENV{'_SERVICE_NOW_URGENCY'}) {
    if ($ENV{'_SERVICE_NOW_URGENCY'}  eq "Warning" ) {
      $urgency = "\"urgency\":\"2 - Medium\"";
    }
    if ($ENV{'_SERVICE_NOW_URGENCY'}  eq "Critical" ) {
      $urgency = "\"urgency\":\"1 - High\"";
    }
  }
}

my $subcategory = '';
if (defined $ENV{'_SERVICE_NOW_SUBCATEGORY'}) { #   {"subcategory":"dsfgdfg"}
  my $tempSubcategory = $ENV{'_SERVICE_NOW_SUBCATEGORY'};
  $subcategory = "\"subcategory\":\"$tempSubcategory\"";
}

my $category = '';
if (defined $ENV{'_SERVICE_NOW_CATEGORY'}) {
  my $tempCategory = $ENV{'_SERVICE_NOW_CATEGORY'};
  $category = "\"category\":\"$tempCategory\"";
}

my $defaultSLA= `date +"%Y-%m-%d %H:%M:%S" -d "+2 hours"`;
$defaultSLA =~ s/\s+$//; my $sla_due="\"sla_due\":\"$defaultSLA\"";
if (defined $ENV{'_OVERRIDE_SERVICE_NOW_SLA_DUE'}) {
  my $tempSlaDue = $ENV{'_OVERRIDE_SERVICE_NOW_SLA_DUE'};
  my $newDate = `date +"%Y-%m-%d %H:%M:%S" -d "$tempSlaDue"`;
  $newDate =~ s/\s+$//;
  $sla_due="\"sla_due\":\"$newDate\"";
} else {
  if (defined $ENV{'_SERVICE_NOW_SLA_DUE'}) {
    my $tempSlaDue = $ENV{'_SERVICE_NOW_SLA_DUE'};
    my $newDate = `date +"%Y-%m-%d %H:%M:%S" -d "$tempSlaDue"`;
    $newDate =~ s/\s+$//;
    $sla_due="\"sla_due\":\"$newDate\"";
  }
}

#print FH "bbbb\n";
#my $host = 'https://liquidnetdev.service-now.com';
#my $host = 'https://liquidnet.service-now.com';
    
my $user = 'itrs';
my $pwd = 'itrsL1quidn3t';
my $severity = $ENV{'_SEVERITY'};
my $sampler = $ENV{'_SAMPLER'};
my $errorMessage = $ENV{'_VALUE'};
my $userData = $ENV{'_USERDATA'};

#my $request_body ="{\"cmdb_ci\":\"$ci\",\"short_description\":\"$sampler\",\"description\":\"$errorMessage $userData\"}";
my $request_body ="{"; my $addedField = 0; if (length $callerId > 0) {
  $request_body = $request_body .  $callerId;
  $addedField = 1;
}
if (length $impactedCI > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $impactedCI;
  $addedField = 1;
}
if (length $sla_due > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $sla_due;
  $addedField = 1;
}
if (length $category > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $category;
  $addedField = 1;
}
if (length $actionable > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $actionable;
  $addedField = 1;
}

if (length $subcategory > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $subcategory;
  $addedField = 1;
}
if (length $assignGroup > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $assignGroup;
  $addedField = 1;
}
if (length $shortDescription > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $shortDescription;
  $addedField = 1;
}
if (length $description > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $description;
  $addedField = 1;
}
if (length $urgency > 0) {
  if ($addedField == 1) {
    $request_body = $request_body .  ",";
  }
  $request_body = $request_body .  $urgency;
  $addedField = 1;
}

if (length $state > 0) {
  if ($addedField == 1) {
    $request_body = $request_body . ",";
  }
  $request_body = $request_body .  $state;
  $addedField = 1;
}

if (length $close_code > 0) {
  if ($addedField == 1) {
    $request_body = $request_body . ",";
  }
  $request_body = $request_body .  $close_code;
  $addedField = 1;
}

if (length $closed_by > 0) {
  if ($addedField == 1) {
    $request_body = $request_body . ",";
  }
  $request_body = $request_body .  $closed_by;
  $addedField = 1;
}

$request_body = $request_body .  "}";

#print FH $host;
#print FH "cccc\n";

#print FH $request_body;

#my $request_body ="{${callerId}${impactedCI}${assignGroup}${shortDescription}${description}}";
#print $request_body;
     
my $client = REST::Client->new(host => $host);
if (substr($ENV{'HOSTNAME'},0,15) eq 'uk1pvitrsgwpd99') {
} else {
   if (substr($ENV{'HOSTNAME'},0,2) eq 'uk') {
       $client->getUseragent()->proxy(['https'], 'http://10.101.221.60:8080/');
   }
}
     
my $encoded_auth = encode_base64("$user:$pwd", '');
       
$client->POST("/api/now/table/incident?sysparm_fields=sys_id%2Cnumber",
              $request_body,
             {'Authorization' => "Basic $encoded_auth",
              'Content-Type' => 'application/json',
              'Accept' => 'application/json'}); 

my $sys_id;
if ($client->responseContent() =~ /sys_id.:.(.+)"/) {
        $sys_id = $1;
        print 'https://liquidnet.service-now.com/nav_to.do?uri=incident.do?sys_id=' . $sys_id . "\n";
}
my $incident_id;
if ($client->responseContent() =~ /number.:.(.+)"/) {
        $incident_id = $1;
        print $incident_id . "\n";
}
if (defined $ENV{'_TEAMS_WEBHOOK_ID'}) {
        $shortDescription = '';
        if (defined $ENV{'_OVERRIDE_SERVICE_NOW_SHORT_DESCRIPTION'}) {
                $shortDescription = $ENV{'_OVERRIDE_SERVICE_NOW_SHORT_DESCRIPTION'};
        } else {
                if (defined $ENV{'_SERVICE_NOW_SHORT_DESCRIPTION'}) {
                        $shortDescription = $ENV{'_SERVICE_NOW_SHORT_DESCRIPTION'};
                }
        }

        $assignGroup = '';
        if (defined $ENV{'_OVERRIDE_SERVICE_NOW_ASSIGN_GROUP'}) {
                $assignGroup = $ENV{'_OVERRIDE_SERVICE_NOW_ASSIGN_GROUP'};
        } else {
                if (defined $ENV{'_SERVICE_NOW_ASSIGN_GROUP'}) {
                        $assignGroup = $ENV{'_SERVICE_NOW_ASSIGN_GROUP'};
                }
        }

        my $teams_body = "{ \"\@type\": \"MessageCard\", \"\@context\": \"http://schema.org/extensions\", \"themeColor\": \"0076D7\", \"summary\": \"" . $shortDescription . "\", \"sections\": [{ \"activityTitle\": \"" . $shortDescription . "\", \"facts\": [{ \"name\": \"Incident ID:\", \"value\": \"" . $incident_id . "\"}, { \"name\": \"Assigned to group:\", \"value\": \"" . $assignGroup . "\" }, { \"name\": \"ServiceNow link:\", \"value\": \"https://liquidnet.service-now.com/nav_to.do?uri=incident.do?sys_id=" . $sys_id . "\"}] }], \"potentialAction\": [{ \"\@type\": \"OpenUri\", \"name\": \"" . $incident_id . "\", \"targets\": [{ \"os\": \"default\", \"uri\": \"https://liquidnet.service-now.com/nav_to.do?uri=incident.do?sys_id=" . $sys_id . "\"}]  }] }";

        my $teams_site = "https://liquidnet.webhook.office.com";
        foreach my $th ( split(' ', $ENV{'_TEAMS_WEBHOOK_ID'} )) {
             my $teams_post = "/webhookb2/" . $th;
             my $teams_client = REST::Client->new(host => $teams_site);
             if (substr($ENV{'HOSTNAME'},0,15) eq 'uk1pvitrsgwpd99') {
             } else {
                 if (substr($ENV{'HOSTNAME'},0,2) eq 'uk') {
                     $teams_client->getUseragent()->proxy(['https'], 'http://10.101.221.60:8080/');
                 }
             }
             $teams_client->POST($teams_post, $teams_body, {'Content-Type' => 'application/json'});
             print $teams_client->responseCode() . "\n";
        }
}
