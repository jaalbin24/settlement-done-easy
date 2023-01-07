module UsersHelper
    def member_role_name(user, args=nil)
        if user.isLawFirm? || user.isAttorney?
            if args.nil?
                return "attorney"
            end
            args[:invert] ? "adjuster" : "attorney"
        elsif user.isInsuranceCompany? || user.isAdjuster?
            if args.nil?
                return "adjuster"
            end
            args[:invert] ? "attorney" : "adjuster"
        else
            ""
        end
    end

    def organization_role_name(user)
        if user.isLawFirm? || user.isAttorney?
            "law firm"
        elsif user.isInsuranceCompany? || user.isAdjuster?
            "insurance company"
        else
            ""
        end
    end
end
