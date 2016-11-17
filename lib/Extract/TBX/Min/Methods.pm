#!usr/bin/perl

package Extract::TBX::Min::Methods;
use strict;
use warnings;
use Exporter::Easy (
	OK => [ 'in_array', 'get_user_input', 'splice_by_val' ]
	);

sub in_array
{
    my ($array_ref, $value) = @_;
    
    my $ret = 0;
    
    foreach (@$array_ref)
    {
        if ( lc($value) eq lc($_) )
        {
            $ret = 1;
            last;
        }
    }
    
    return $ret;
}

sub get_user_input
{
    my ($prompt, $err_prompt, $allowed_vals_ref) = @_;
    
    print "\n$prompt";
    while (<STDIN>)
    {
        chomp;
        if (!in_array($allowed_vals_ref, $_))
        {
            print "\n$err_prompt";
            next;
        }

        return $_;
    }
}

sub splice_by_val
{
    my ($array, $val) = @_;
    my $i = 0;
    foreach (@$array)
    {
        last if (lc($val) eq lc($_));
        $i++;
    }
    
    splice(@$array, $i, 1);
    
    return $array;
}

1;