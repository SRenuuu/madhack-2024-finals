enum Industries {
  informationTechnology,
  healthcare,
  finance,
  education,
  other,
}

enum Categories {
  softwareDevelopment,
  marketing,
  sales,
  customerService,
  other,
}

enum JobTypes {
  fullTime,
  partTime,
  contract,
  internship,
  freelance,
}

enum TypeOfWorkspace {
  onSite,
  remote,
  hybrid,
}
extension IndustriesExtension on Industries {
  String get displayName {
    switch (this) {
      case Industries.informationTechnology:
        return 'Information Technology';
      case Industries.healthcare:
        return 'Healthcare';
      case Industries.finance:
        return 'Finance';
      case Industries.education:
        return 'Education';
      case Industries.other:
        return 'Other';
      default:
        throw Exception('Unknown Industry');
    }
  }
}

extension CategoriesExtension on Categories {
  String get displayName {
    switch (this) {
      case Categories.softwareDevelopment:
        return 'Software Development';
      case Categories.marketing:
        return 'Marketing';
      case Categories.sales:
        return 'Sales';
      case Categories.customerService:
        return 'Customer Service';
      case Categories.other:
        return 'Other';
      default:
        throw Exception('Unknown Category');
    }
  }
}

extension JobTypesExtension on JobTypes {
  String get displayName {
    switch (this) {
      case JobTypes.fullTime:
        return 'Full Time';
      case JobTypes.partTime:
        return 'Part Time';
      case JobTypes.contract:
        return 'Contract';
      case JobTypes.internship:
        return 'Internship';
      case JobTypes.freelance:
        return 'Freelance';
      default:
        throw Exception('Unknown Job Type');
    }
  }
}

extension TypeOfWorkspaceExtension on TypeOfWorkspace {
  String get displayName {
    switch (this) {
      case TypeOfWorkspace.onSite:
        return 'On Site';
      case TypeOfWorkspace.remote:
        return 'Remote';
      case TypeOfWorkspace.hybrid:
        return 'Hybrid';
      default:
        throw Exception('Unknown Workspace Type');
    }
  }
}
