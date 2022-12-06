// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAllPokemonQuery: GraphQLQuery {
  public static let operationName: String = "GetAllPokemon"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query GetAllPokemon($offset: Int) {
        getAllPokemon(offset: $offset) {
          __typename
          num
          color
          baseSpecies
          key
          sprite
          types {
            __typename
            name
          }
          preevolutions {
            __typename
            num
            color
            key
          }
          evolutions {
            __typename
            num
            color
            key
          }
        }
      }
      """
    ))

  public var offset: GraphQLNullable<Int>

  public init(offset: GraphQLNullable<Int>) {
    self.offset = offset
  }

  public var __variables: Variables? { ["offset": offset] }

  public struct Data: PokemonAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { PokemonAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("getAllPokemon", [GetAllPokemon].self, arguments: ["offset": .variable("offset")]),
    ] }

    /// Returns a list of all the known Pokémon.
    ///
    /// For every Pokémon all the data on each requested field is returned.
    ///
    /// **_NOTE:_ To skip all CAP Pokémon, PokéStar Pokémon, and Missingno provide an `offset` of 87**
    ///
    /// You can provide `take` to limit the amount of Pokémon to return (default: 1), set the offset of where to start with `offset`, and reverse the entire array with `reverse`.
    ///
    /// You can provide `takeFlavorTexts` to limit the amount of flavour texts to return, set the offset of where to start with `offsetFlavorTexts`, and reverse the entire array with `reverseFlavorTexts`.
    ///
    /// While the API will currently not rate limit the usage of this query, it may do so in the future.
    ///
    /// It is advisable to cache responses of this query.
    public var getAllPokemon: [GetAllPokemon] { __data["getAllPokemon"] }

    /// GetAllPokemon
    ///
    /// Parent Type: `Pokemon`
    public struct GetAllPokemon: PokemonAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { PokemonAPI.Objects.Pokemon }
      public static var __selections: [Selection] { [
        .field("num", Int.self),
        .field("color", String.self),
        .field("baseSpecies", String?.self),
        .field("key", GraphQLEnum<PokemonEnum>.self),
        .field("sprite", String.self),
        .field("types", [Type_SelectionSet].self),
        .field("preevolutions", [Preevolution]?.self),
        .field("evolutions", [Evolution]?.self),
      ] }

      /// The dex number for a Pokémon
      public var num: Int { __data["num"] }
      /// The colour of a Pokémon as listed in the Pokedex
      public var color: String { __data["color"] }
      /// Base species if this entry describes a special form
      public var baseSpecies: String? { __data["baseSpecies"] }
      /// The key of the Pokémon as stored in the API
      public var key: GraphQLEnum<PokemonEnum> { __data["key"] }
      /// The sprite for a Pokémon. For most Pokémon this will be the animated gif, with some exceptions that were older-gen exclusive
      public var sprite: String { __data["sprite"] }
      /// The types for a Pokémon
      public var types: [Type_SelectionSet] { __data["types"] }
      /// The preevolutions for a Pokémon, if any
      public var preevolutions: [Preevolution]? { __data["preevolutions"] }
      /// The evolutions for a Pokémon, if any
      public var evolutions: [Evolution]? { __data["evolutions"] }

      /// GetAllPokemon.Type_SelectionSet
      ///
      /// Parent Type: `PokemonType`
      public struct Type_SelectionSet: PokemonAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { PokemonAPI.Objects.PokemonType }
        public static var __selections: [Selection] { [
          .field("name", String.self),
        ] }

        /// The name of the typ
        public var name: String { __data["name"] }
      }

      /// GetAllPokemon.Preevolution
      ///
      /// Parent Type: `Pokemon`
      public struct Preevolution: PokemonAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { PokemonAPI.Objects.Pokemon }
        public static var __selections: [Selection] { [
          .field("num", Int.self),
          .field("color", String.self),
          .field("key", GraphQLEnum<PokemonEnum>.self),
        ] }

        /// The dex number for a Pokémon
        public var num: Int { __data["num"] }
        /// The colour of a Pokémon as listed in the Pokedex
        public var color: String { __data["color"] }
        /// The key of the Pokémon as stored in the API
        public var key: GraphQLEnum<PokemonEnum> { __data["key"] }
      }

      /// GetAllPokemon.Evolution
      ///
      /// Parent Type: `Pokemon`
      public struct Evolution: PokemonAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { PokemonAPI.Objects.Pokemon }
        public static var __selections: [Selection] { [
          .field("num", Int.self),
          .field("color", String.self),
          .field("key", GraphQLEnum<PokemonEnum>.self),
        ] }

        /// The dex number for a Pokémon
        public var num: Int { __data["num"] }
        /// The colour of a Pokémon as listed in the Pokedex
        public var color: String { __data["color"] }
        /// The key of the Pokémon as stored in the API
        public var key: GraphQLEnum<PokemonEnum> { __data["key"] }
      }
    }
  }
}
