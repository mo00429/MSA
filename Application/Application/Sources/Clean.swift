/**

 # 개념 정리
 
/*
 
 Application에서 하위 Dynamic Framework들을 추가하지 않으면 Linking 에러로 dyld 에러가 발생하므로 추가해줘야한다.
 
 : 현재 상태
 Application -> Feature -> Domain <-❓ Data -> Networking
 
 : 원하는 방향
 Application -> Feature -> Domain -> Data -> Networking
 
 */

// MARK: - Application Module

import Data
import Domain
import Feature

class AppDelegate {
    
    func 앱시작() {
        // 주입
        let viewControler = ViewController(
            viewModel: ViewModel(
                useCase: UseCaseImpl(
                    repository: RepositoryImpl()
                )
            )
        )
        window?.rootViewController = viewControler
    }
}


// MARK: - Feature(Presentation) Module

import Domain

struct Item: Equatable, Hashable {
    
}

enum PresentationMapper {
    static func mapping(entity: Entity) -> Item {
        return Item()
    }
}

class ViewController {
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

class ViewModel {
    @Published var item: Item?
    let useCase: UseCase
    
    init(useCase: UseCase) {
        self.useCase = useCase
    }
    
    func fetch() {
        let entity = useCase.execute()
        item = PresentationMapper.mapping(entity: entity)
    }
}

// MARK: - Domain Module

struct Entity {
    
}

protocol UseCase {
    func execute() -> Entity
}

class UseCaseImpl: UseCase {
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func execute() -> Entity {
        return Entity()
    }
}


protocol Repository {
    func fetchEntity() -> Entity
}

// MARK: - Data Module

import Domain
import Networking

struct Model: Decodable {
    
}

enum DataMapper {
    static func mapping(model: Model) -> Entity {
        return Entity()
    }
}

class RepositoryImpl: Repository {
    
    let network = Network...
    
    func fetchEntity() -> Entity {
        let sampleModel = Model()
        let entity = DataMapper.mapping(model: sampleModel)
        return entity
    }
}

// ...

/**
 
 DI의 경우 DI 모듈을 따로 두어서 해결할 수 있을 것 같음
 
 Application -> DI -> ...
 
 */

import DI

class AppDelegate {
    
    func 앱시작() {
        // 주입
        let viewControler = DI.makeViewController()
        
        window?.rootViewController = viewControler
    }
}
 */
