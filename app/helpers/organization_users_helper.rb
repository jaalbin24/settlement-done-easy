module OrganizationUsersHelper
    def member_role_name(user)
        if user.isLawFirm? || user.isAttorney?
            return "attorney"
        elsif user.isInsuranceCompany? || user.isAdjuster?
            return "adjuster"
        else
            return ""
        end
    end

    def organization_role_name(user)
        if user.isLawFirm? || user.isAttorney?
            return "law firm"
        elsif user.isInsuranceCompany? || user.isAdjuster?
            return "insurance company"
        end
    end
end
