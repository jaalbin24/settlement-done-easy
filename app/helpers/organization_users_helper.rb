module OrganizationUsersHelper
    def member_role_name(user)
        if user.isLawFirm?
            return "attorney"
        elsif user.isInsuranceCompany?
            return "adjuster"
        else
            return ""
        end
    end

    def organization_role_name(user)
        if user.isAttorney?
            return "law firm"
        elsif user.isAdjuster?
            return "insurance company"
        end
    end
end
