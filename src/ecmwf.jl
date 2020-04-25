using ClimateERA

adderaparams() = eraparametersadd(srcdir("eraparams.txt"));

function ecmwfdwn(init::Dict,eroot::AbstractString;
    modID::AbstractString, parID::AbstractString,
    regID::AbstractString="GLB"
)

    emod,epar,ereg,etime = erainitialize(init,modID=modID,parID=parID,regID=regID);
    eradownload(emod,epar,ereg,etime,eroot)

end

function ecmwfana(init::Dict,eroot::AbstractString
    plvls::Union{AbstractString,Vector{<:Real}};
    modID::AbstractString, parID::AbstractString,
    regID::AbstractString="GLB"
)

    emod,epar,ereg,etime = erainitialize(init,modID=modID,parID=parID,regID=regID);

    if plvls == "sfc"
        epar["level"] = plvls; eraanalysis(emod,epar,ereg,etime,eroot);
    else
        for pii in plvls;
            epar["level"] = pii; eraanalysis(emod,epar,ereg,etime,eroot);
        end
    end

end
