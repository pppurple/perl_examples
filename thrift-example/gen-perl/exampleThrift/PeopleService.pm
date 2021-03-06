#
# Autogenerated by Thrift Compiler (0.10.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
require 5.6.0;
use strict;
use warnings;
use Thrift;

use exampleThrift::Types;

# HELPER FUNCTIONS AND STRUCTURES

package exampleThrift::PeopleService_searchByName_args;
use base qw(Class::Accessor);
exampleThrift::PeopleService_searchByName_args->mk_accessors( qw( query ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{query} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{query}) {
      $self->{query} = $vals->{query};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'PeopleService_searchByName_args';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1) 
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^1$/ && do{      if ($ftype == TType::STRING) {
        $xfer += $input->readString(\$self->{query});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('PeopleService_searchByName_args');
  if (defined $self->{query}) {
    $xfer += $output->writeFieldBegin('query', TType::STRING, 1);
    $xfer += $output->writeString($self->{query});
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package exampleThrift::PeopleService_searchByName_result;
use base qw(Class::Accessor);
exampleThrift::PeopleService_searchByName_result->mk_accessors( qw( success ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{success} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{success}) {
      $self->{success} = $vals->{success};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'PeopleService_searchByName_result';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1) 
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^0$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size0 = 0;
          $self->{success} = [];
          my $_etype3 = 0;
          $xfer += $input->readListBegin(\$_etype3, \$_size0);
          for (my $_i4 = 0; $_i4 < $_size0; ++$_i4)
          {
            my $elem5 = undef;
            $elem5 = new exampleThrift::Person();
            $xfer += $elem5->read($input);
            push(@{$self->{success}},$elem5);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('PeopleService_searchByName_result');
  if (defined $self->{success}) {
    $xfer += $output->writeFieldBegin('success', TType::LIST, 0);
    {
      $xfer += $output->writeListBegin(TType::STRUCT, scalar(@{$self->{success}}));
      {
        foreach my $iter6 (@{$self->{success}}) 
        {
          $xfer += ${iter6}->write($output);
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package exampleThrift::PeopleServiceIf;

use strict;


sub searchByName{
  my $self = shift;
  my $query = shift;

  die 'implement interface';
}

package exampleThrift::PeopleServiceRest;

use strict;


sub new {
  my ($classname, $impl) = @_;
  my $self     ={ impl => $impl };

  return bless($self,$classname);
}

sub searchByName{
  my ($self, $request) = @_;

  my $query = ($request->{'query'}) ? $request->{'query'} : undef;
  return $self->{impl}->searchByName($query);
}

package exampleThrift::PeopleServiceClient;


use base qw(exampleThrift::PeopleServiceIf);
sub new {
  my ($classname, $input, $output) = @_;
  my $self      = {};
  $self->{input}  = $input;
  $self->{output} = defined $output ? $output : $input;
  $self->{seqid}  = 0;
  return bless($self,$classname);
}

sub searchByName{
  my $self = shift;
  my $query = shift;

    $self->send_searchByName($query);
  return $self->recv_searchByName();
}

sub send_searchByName{
  my $self = shift;
  my $query = shift;

  $self->{output}->writeMessageBegin('searchByName', TMessageType::CALL, $self->{seqid});
  my $args = new exampleThrift::PeopleService_searchByName_args();
  $args->{query} = $query;
  $args->write($self->{output});
  $self->{output}->writeMessageEnd();
  $self->{output}->getTransport()->flush();
}

sub recv_searchByName{
  my $self = shift;

  my $rseqid = 0;
  my $fname;
  my $mtype = 0;

  $self->{input}->readMessageBegin(\$fname, \$mtype, \$rseqid);
  if ($mtype == TMessageType::EXCEPTION) {
    my $x = new TApplicationException();
    $x->read($self->{input});
    $self->{input}->readMessageEnd();
    die $x;
  }
  my $result = new exampleThrift::PeopleService_searchByName_result();
  $result->read($self->{input});
  $self->{input}->readMessageEnd();

  if (defined $result->{success} ) {
    return $result->{success};
  }
  die "searchByName failed: unknown result";
}
package exampleThrift::PeopleServiceProcessor;

use strict;


sub new {
    my ($classname, $handler) = @_;
    my $self      = {};
    $self->{handler} = $handler;
    return bless ($self, $classname);
}

sub process {
    my ($self, $input, $output) = @_;
    my $rseqid = 0;
    my $fname  = undef;
    my $mtype  = 0;

    $input->readMessageBegin(\$fname, \$mtype, \$rseqid);
    my $methodname = 'process_'.$fname;
    if (!$self->can($methodname)) {
      $input->skip(TType::STRUCT);
      $input->readMessageEnd();
      my $x = new TApplicationException('Function '.$fname.' not implemented.', TApplicationException::UNKNOWN_METHOD);
      $output->writeMessageBegin($fname, TMessageType::EXCEPTION, $rseqid);
      $x->write($output);
      $output->writeMessageEnd();
      $output->getTransport()->flush();
      return;
    }
    $self->$methodname($rseqid, $input, $output);
    return 1;
}

sub process_searchByName {
    my ($self, $seqid, $input, $output) = @_;
    my $args = new exampleThrift::PeopleService_searchByName_args();
    $args->read($input);
    $input->readMessageEnd();
    my $result = new exampleThrift::PeopleService_searchByName_result();
    $result->{success} = $self->{handler}->searchByName($args->query);
    $output->writeMessageBegin('searchByName', TMessageType::REPLY, $seqid);
    $result->write($output);
    $output->writeMessageEnd();
    $output->getTransport()->flush();
}

1;
